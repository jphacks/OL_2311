import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    this.indicator,
    this.actions,
    this.onPopHandler,
  });

  final String title;
  final String? description;
  final Widget child;
  final void Function() onNextPressed;
  final String nextLabel;
  final bool hide;
  final bool loading;
  final int? indicator;
  final List<Widget>? actions;
  final Future<void> Function()? onPopHandler;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initIndicator = useMemoized(() => indicator);

    final controller = useAnimationController(
        lowerBound: ((indicator ?? 0)) / 3,
        upperBound: ((indicator ?? 0) + 1) / 3,
        duration: const Duration(milliseconds: 200));

    useEffect(() {
      if (initIndicator == null || indicator == null) {
        return null;
      }

      if (initIndicator < indicator!) {
        controller.forward(from: 0);
      }
      return null;
    }, [indicator]);

    final appbar = AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () async {
          await onPopHandler?.call();
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black87,
        ),
      ),
      actions: actions,
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
                  const SizedBox(height: 16),
                  if (indicator != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AnimatedBuilder(
                          animation: controller,
                          builder: (context, _) {
                            return Hero(
                              tag: "LinearProgressIndicator",
                              child: LinearProgressIndicator(
                                value: controller.value,
                                color: const Color(0xff1738FD),
                                backgroundColor: const Color(0xffE0E0E0),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 16),
                  ],
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
              Expanded(
                child: child,
              ),
            ]),
      ),
      bottomNavigationBar: Visibility(
        visible: !hide,
        child: BottomAppBar(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
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
                      onPressed: hide ? null : onNextPressed,
                      child: Text(
                        nextLabel,
                      ))),
        ),
      ),
    );
  }
}
