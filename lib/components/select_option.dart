import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectOption extends HookConsumerWidget {
  const SelectOption(
      {super.key,
      required this.onSelected,
      required this.isSelected,
      required this.child});

  final Widget child;
  final void Function() onSelected;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(
      onPressed: onSelected,
      style: ButtonStyle(
        alignment: Alignment.centerLeft,
        backgroundColor: MaterialStateProperty.all(
          isSelected ? Theme.of(context).primaryColor : Colors.white,
        ),
        foregroundColor: MaterialStateProperty.all(
            isSelected ? Colors.white : Colors.black87),
        textStyle: MaterialStateProperty.all(const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            height: 1.5,
            color: Colors.black87)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
        animationDuration: Duration.zero,
        splashFactory: NoSplash.splashFactory,
      ),
      child: child,
    );
  }
}
