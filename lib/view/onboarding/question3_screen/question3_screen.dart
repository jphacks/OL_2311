import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/components/form_item.dart';
import 'package:kanpai/view/onboarding/connect_screen/connect_screen.dart';
import 'package:kanpai/view/onboarding/onboarding_layout.dart';

class Question3Screen extends HookConsumerWidget {
  const Question3Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final xController = useTextEditingController();
    final instagramController = useTextEditingController();
    final homepageController = useTextEditingController();

    return OnboardingLayout(
        title: "SNSで繋がろう",
        description: "※乾杯した相手に公開されます",
        nextLabel: "コップと接続する",
        onNextPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const ConnectScreen()));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormItem(
              label: "X",
              controller: xController,
              hintText: "IDを入力してください",
            ),
            const SizedBox(height: 16),
            FormItem(
              label: "Instagram",
              controller: instagramController,
              hintText: "IDを入力してください",
            ),
            const SizedBox(height: 16),
            FormItem(
              label: "ホームページ",
              controller: homepageController,
              hintText: "リンクを入力してください",
            ),
          ],
        ));
  }
}
