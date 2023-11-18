import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/components/water_animation.dart';
import 'package:kanpai/main.dart';
import 'package:kanpai/view/kanpai/kanpai_screen.dart';
import 'package:kanpai/view/onboarding/connect_screen/qr_capture_sheet.dart';
import 'package:kanpai/view/onboarding/onboarding_layout.dart';
import 'package:kanpai/view_models/connect_view_model.dart';
import 'package:kanpai/view_models/question2_view_model.dart';

class ConnectScreen extends HookConsumerWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnecting = ref.watch(connectViewModelProvider).isConnecting;
    final viewmodel = ref.watch(connectViewModelProvider.notifier);
    final hasError = ref.watch(connectViewModelProvider).hasError;
    final prefs = ref.watch(sharedPreferencesProvider);
    final selectedTechArea =
        ref.watch(question2ViewModelProvider).asData?.value;

    final controller = useWaterAnimationController();

    final showParingSheet = useCallback(() async {
      final code = await showQrCaptureSheet(context);

      if (code == null) {
        return;
      }

      final debugDeviceId = prefs.getString("deviceUuid");
      final bleUserId = prefs.getString("bleUserId");

      final deviceId = (debugDeviceId == null || debugDeviceId.isEmpty)
          ? code
          : debugDeviceId;

      final connectedDevice =
          await viewmodel.connect(deviceId, bleUserId!, selectedTechArea);
      if (connectedDevice == null) {
        return;
      }

      controller.start();
      await Future.delayed(const Duration(milliseconds: 4000));

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            KanpaiScreen(targetDevice: null),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ));

      controller.reset();
    }, []);

    useEffect(() {
      // ref: https://note.com/_hi/n/na4f4a53857f7
      Future.microtask(() => showParingSheet());
      return null;
    }, []);

    return WaterAnimation(
      controller: controller,
      duration: const Duration(milliseconds: 3000),
      direction: WaterAnimationDirection.up,
      child: OnboardingLayout(
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
            onPressed: () async {
              controller.start();
              await Future.delayed(const Duration(milliseconds: 4000));
              if (!context.mounted) {
                return;
              }
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    KanpaiScreen(targetDevice: null),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                transitionDuration: const Duration(milliseconds: 1000),
              ));
              controller.reset();
            },
          ),
        ],
        onNextPressed: showParingSheet,
        child: SizedBox(
          height: double.infinity,
          child: Center(
            child: Image.asset('assets/images/cup-image.png'),
          ),
        ),
      ),
    );
  }
}
