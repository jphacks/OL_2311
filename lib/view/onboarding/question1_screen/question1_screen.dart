import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/components/select_option.dart';
import 'package:kanpai/view/onboarding/onboarding_layout.dart';
import 'package:kanpai/view/onboarding/question1_screen/location.dart';
import 'package:kanpai/view/onboarding/question2_screen/question2_screen.dart';

class Question1Screen extends HookConsumerWidget {
  const Question1Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final residenceArea = useState<Location?>(null);

    return OnboardingLayout(
      title: "出身地はどこですか？",
      hide: residenceArea.value == null,
      onNextPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const Question2Screen()));
      },
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: Location.values.map((item) {
            final isSelected = residenceArea.value == item;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SelectOption(
                isSelected: isSelected,
                onSelected: () {
                  residenceArea.value = item;
                },
                child: Text(item.label),
              ),
            );
          }).toList()),
    );
  }
}
