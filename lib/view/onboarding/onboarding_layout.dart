import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingLayout extends HookConsumerWidget {
  const OnboardingLayout({
    super.key,
    required this.title,
    this.description,
    required this.child,
    required this.onNextPressed,
    this.nextLabel = "次へ",
    this.hide = false,
    this.loading = false,
  });

  final String title;
  final String? description;
  final Widget child;
  final void Function() onNextPressed;
  final String nextLabel;
  final bool hide;
  final bool loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appbar = AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black87,
        ),
      ),
    );

    return Scaffold(
        appBar: appbar,
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        body: Padding(
          padding: EdgeInsets.only(
              top: 32 + 16 + appbar.preferredSize.height,
              left: 32,
              right: 32,
              bottom: 32),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    if (description != null)
                      Text(
                        description!,
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Expanded(child: child),
                const SizedBox(
                  height: 32,
                ),
                Opacity(
                  opacity: hide ? 0 : 1,
                  child: SizedBox(
                    width: double.infinity,
                    child: loading
                        ? FilledButton.icon(
                            icon: const SizedBox.square(
                              dimension: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1.5,
                              ),
                            ),
                            onPressed: null,
                            label: Text(nextLabel),
                          )
                        : FilledButton(
                            onPressed: (hide) ? null : onNextPressed,
                            child: Text(
                              nextLabel,
                            )),
                  ),
                )
              ]),
        ));
  }
}
