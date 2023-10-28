import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/view/onboarding/onboarding_layout.dart';

class ConnectScreen extends HookConsumerWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnecting = useState(false);

    return OnboardingLayout(
      title: "接続を開始しますか？",
      // TODO: 注意書きがあれば追加
      // description: "注意書き",
      loading: isConnecting.value,
      nextLabel: isConnecting.value ? "接続中..." : "接続を開始",
      onNextPressed: () async {
        isConnecting.value = true;
        await Future.delayed(const Duration(seconds: 2));
        isConnecting.value = false;
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
