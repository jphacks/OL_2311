import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/util/ble_connector.dart';
import 'package:kanpai/view/onboarding/onboarding_layout.dart';
import 'package:kanpai/viewmodel/connect_viewmodel.dart';

class ConnectScreen extends HookConsumerWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnecting = ref.watch(connectViewModelProvider).isConnecting;
    final bleConnctor = ref.watch(bleConnectorProvider);

    return OnboardingLayout(
      title: "接続を開始しますか？",
      // TODO: 注意書きがあれば追加
      // description: "注意書き",
      loading: isConnecting,
      nextLabel: isConnecting ? "接続中..." : "接続を開始",
      onNextPressed: () async {
        await bleConnctor.connect();
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
