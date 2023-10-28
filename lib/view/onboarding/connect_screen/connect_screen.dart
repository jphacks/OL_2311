import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/view/onboarding/onboarding_layout.dart';
import 'package:kanpai/viewmodel/connect_viewmodel.dart';

class ConnectScreen extends HookConsumerWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnecting = ref.watch(connectViewModelProvider).isConnecting;
    final viewmodel = ref.watch(connectViewModelProvider.notifier);
    final hasError = ref.watch(connectViewModelProvider).hasError;

    return hasError
        ? OnboardingLayout(
            title: "接続に失敗しました",
            loading: isConnecting,
            nextLabel: isConnecting ? "接続中..." : "再接続する",
            onNextPressed: () async {
              final connectedDevice = await viewmodel.connect();
            },
            child: SizedBox(
              height: double.infinity,
              child: Center(
                child: Image.asset('assets/images/cup-image.png'),
              ),
            ),
          )
        : OnboardingLayout(
            title: "接続を開始しますか？",
            // TODO: 注意書きがあれば追加
            // description: "注意書き",
            loading: isConnecting,
            nextLabel: isConnecting ? "接続中..." : "接続を開始",
            onNextPressed: () async {
              final connectedDevice = await viewmodel.connect();
            },
            child: SizedBox(
              height: double.infinity,
              child: Center(
                child: Image.asset('assets/images/cup-image.png'),
              ),
            ),
          );
  }
}
