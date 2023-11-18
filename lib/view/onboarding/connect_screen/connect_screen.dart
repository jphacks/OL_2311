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

class WaterRoute<T> extends PageRoute<T> {
  WaterRoute({required this.builder}) : super();

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 3000);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return Stack(
      children: [
        WaterAnimation(
            duration: const Duration(milliseconds: 750),
            animation: animation.drive(Tween(begin: 1.0, end: 0.0)),
            direction: WaterAnimationDirection.down,
            child: AnimatedBuilder(
              animation: animation.drive(TweenSequence([
                TweenSequenceItem(
                  tween: Tween(begin: 0.0, end: 0.0),
                  weight: 10,
                ),
                TweenSequenceItem(
                  tween: Tween(begin: 0.0, end: 1.0),
                  weight: 1,
                ),
                TweenSequenceItem(
                  tween: Tween(begin: 1.0, end: 1.0),
                  weight: 10,
                ),
              ])),
              builder: (context, _) {
                return Opacity(
                    opacity: animation.value < 0.5
                        ? 0
                        : 0.5 < animation.value
                            ? 1.0
                            : animation.value,
                    child: child);
              },
              child: child,
            ))
      ],
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  String? get barrierLabel => "とじる";
}

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

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).push(WaterRoute(
        builder: (context) => KanpaiScreen(targetDevice: connectedDevice),
      ));
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
          onPressed: () {
            Navigator.of(context).push(WaterRoute(
              builder: (context) => KanpaiScreen(targetDevice: null),
            ));
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
    );
  }
}
