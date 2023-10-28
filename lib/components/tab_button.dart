import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabButton extends HookConsumerWidget {
  const TabButton({
    super.key,
    required this.isSelected,
    required this.onSelected,
    required this.child,
  });

  final bool isSelected;
  final void Function() onSelected;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
            color: isSelected ? Colors.black87 : Colors.transparent, width: 3),
      )),
      padding: EdgeInsets.zero,
      child: TextButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 5, horizontal: 8)),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor: MaterialStateProperty.all(Colors.black87),
            overlayColor: MaterialStateProperty.all(Colors.black12),
            animationDuration: Duration.zero,
            splashFactory: NoSplash.splashFactory,
          ),
          onPressed: onSelected,
          child: child
          // child: Text("すべて",
          //     style: Theme.of(context)
          //         .textTheme
          //         .labelLarge
          //         ?.copyWith(fontWeight: FontWeight.bold)),
          ),
    );
  }
}
