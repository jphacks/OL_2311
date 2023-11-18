import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TutorialLayout extends HookConsumerWidget {
  const TutorialLayout({
    super.key,
    required this.child,
    required this.onNextPressed,
    required this.indicator,
    this.onSkip,
    this.nextLabel = "次へ",
  });

  final Widget child;
  final void Function() onNextPressed;
  final void Function()? onSkip;
  final String nextLabel;
  final int indicator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: null,
            automaticallyImplyLeading: false),
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        body: Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 32),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 23, horizontal: 36),
                  child: Row(
                    children: [
                      _buildIndicatorItem(indicator, 0),
                      const SizedBox(
                        width: 8,
                      ),
                      _buildIndicatorItem(indicator, 1),
                      const SizedBox(
                        width: 8,
                      ),
                      _buildIndicatorItem(indicator, 2),
                      const SizedBox(
                        width: 8,
                      ),
                      _buildIndicatorItem(indicator, 3),
                    ],
                  ),
                ),
                Expanded(
                  child: child,
                ),
              ]),
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            shadowColor: Colors.transparent,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FilledButton(
                          onPressed: onNextPressed,
                          child: Text(
                            nextLabel,
                          )),
                      AnimatedScale(
                        scale: onSkip == null ? 0 : 1,
                        duration: const Duration(milliseconds: 300),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            TextButton(
                                onPressed: onSkip,
                                child: const Text(
                                  "スキップ",
                                  style: TextStyle(color: Colors.black54),
                                ))
                          ],
                        ),
                      )
                    ]))));
  }

  Expanded _buildIndicatorItem(int indicator, int page) {
    return Expanded(
        child: Container(
      width: double.infinity,
      height: 4,
      decoration: BoxDecoration(
        color: indicator == page ? const Color(0xff1738FD) : Colors.grey[300],
        borderRadius: BorderRadius.circular(999),
      ),
    ));
  }
}
