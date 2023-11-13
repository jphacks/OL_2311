import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/main.dart';
import 'package:kanpai/view/kanpai/kanpai_screen.dart';
import 'package:kanpai/view/onboarding/connect_screen/qr_capture_sheet.dart';
import 'package:kanpai/view/onboarding/onboarding_layout.dart';
import 'package:kanpai/view_models/connect_view_model.dart';

class ConnectScreen extends HookConsumerWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnecting = ref.watch(connectViewModelProvider).isConnecting;
    final viewmodel = ref.watch(connectViewModelProvider.notifier);
    final hasError = ref.watch(connectViewModelProvider).hasError;
    final prefs = ref.watch(sharedPreferencesProvider);

    final showParingSheet = useCallback(() async {
      final code = await showQrCaptureSheet(context);

      if (code == null) {
        return;
      }

      final deviceId = prefs.getString("deviceUuid");
      final bleUserId = prefs.getString("bleUserId");

      final connectedDevice = await viewmodel.connect(deviceId!, bleUserId!);
      if (connectedDevice == null) {
        return;
      }
      if (!context.mounted) {
        return;
      }
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => KanpaiScreen(targetDevice: connectedDevice),
        ),
      );
    }, []);

    useEffect(() {
      // ref: https://note.com/_hi/n/na4f4a53857f7
      Future.microtask(() => showParingSheet());
      return null;
    }, []);

    return OnboardingLayout(
      title: hasError ? "接続に失敗しました" : "接続を開始しますか？",
      loading: isConnecting,
      nextLabel: isConnecting ? "接続中..." : "接続を開始",
      actions: [
        IconButton(
          icon: const Icon(
            Icons.arrow_forward,
            size: 30,
            color: Colors.transparent,
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => KanpaiScreen(targetDevice: null),
            ),
          ),
        ),
      ],
      onNextPressed: showParingSheet,
      child: SizedBox(
        height: double.infinity,
        child: Center(
          child: Image.asset('assets/images/cup-image.png'),
        ),
      ),
    );
  }
}
