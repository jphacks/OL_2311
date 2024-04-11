import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/components/form_item.dart';
import 'package:kanpai/view/onboarding/connect_screen/connect_screen.dart';
import 'package:kanpai/view/onboarding/onboarding_layout.dart';
import 'package:kanpai/view_models/question3_view_model.dart';

class Question2Screen extends HookConsumerWidget {
  const Question2Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final question3ViewModel = ref.watch(question3ViewModelProvider.notifier);

    final xController = useTextEditingController();
    final instagramController = useTextEditingController();
    final githubController = useTextEditingController();
    final websiteController = useTextEditingController();

    return OnboardingLayout(
        title: "SNSで繋がろう",
        description: "※入力されたSNSは乾杯した相手にのみ公開されます",
        nextLabel: "コップと接続する",
        indicator: 3,
        onNextPressed: () {
          question3ViewModel.updateMe(
              xController.text,
              instagramController.text,
              githubController.text,
              websiteController.text);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const ConnectScreen(),
            ),
          );
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: FormItem(
                  label: "X",
                  controller: xController,
                  hintText: "IDを入力してください",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: FormItem(
                  label: "Instagram",
                  controller: instagramController,
                  hintText: "IDを入力してください",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: FormItem(
                  label: "GitHub",
                  controller: githubController,
                  hintText: "IDを入力してください",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: FormItem(
                  label: "ウェブサイト",
                  controller: websiteController,
                  hintText: "URLを入力してください",
                ),
              )
            ],
          ),
        ));
  }
}
