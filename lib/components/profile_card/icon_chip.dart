import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum IconChipSize { md, lg }

class IconChip extends HookConsumerWidget {
  const IconChip({
    super.key,
    required this.imageUrl,
    required this.ringImageUrl,
    this.size = IconChipSize.md,
  });

  final String imageUrl;
  final String ringImageUrl;
  final IconChipSize size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return CircleAvatar(radius: 30, backgroundImage: NetworkImage(imageUrl));
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: size == IconChipSize.md ? 30 : 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Image.network(imageUrl),
          ),
        ),
        Image.asset(
          ringImageUrl,
          width: size == IconChipSize.md ? 80 : 110,
          height: size == IconChipSize.md ? 80 : 110,
        ),
      ],
    );
  }
}
