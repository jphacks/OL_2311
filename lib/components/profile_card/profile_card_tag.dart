import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileCardTag extends HookConsumerWidget {
  const ProfileCardTag({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svgs/cup.svg",
            height: 16,
            theme: const SvgTheme(currentColor: Colors.white),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
