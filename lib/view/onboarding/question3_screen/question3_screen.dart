import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/components/form_item.dart';
import 'package:kanpai/view/onboarding/connect_screen/connect_screen.dart';
import 'package:kanpai/view/onboarding/onboarding_layout.dart';
import 'package:kanpai/view_models/question3_view_model.dart';

class Question3Screen extends HookConsumerWidget {
  const Question3Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final question3ViewModel = ref.watch(question3ViewModelProvider.notifier);

    final isDirty = useState(false);

    final xController = useTextEditingController();
    final instagramController = useTextEditingController();
    final githubController = useTextEditingController();
    final websiteController = useTextEditingController();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isDirty.value = true;
      });

      return null;
    }, []);

    return OnboardingLayout(
        title: "SNSで繋がろう",
        description: "※入力されたSNSは乾杯した相手にのみ公開されます",
        nextLabel: "コップと接続する",
        indicator: isDirty.value ? 3 : 2,
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
                label: "GitHub",
                controller: githubController,
                hintText: "IDを入力してください",
              ),
              const SizedBox(height: 16),
              FormItem(
                label: "ウェブサイト",
                controller: websiteController,
                hintText: "URLを入力してください",
              ),
              const SizedBox(height: 16),
            ],
          ),
        ));
  }
}
