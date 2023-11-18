import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

WaterAnimationController useWaterAnimationController() {
  final controller = useMemoized(() => WaterAnimationController());
  return controller;
}

class MyPainter extends CustomPainter {
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;

  MyPainter(
    this.firstValue,
    this.secondValue,
    this.thirdValue,
    this.fourthValue,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF667BFD).withOpacity(0.99)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height / firstValue)
      ..cubicTo(size.width * .4, size.height / secondValue, size.width * .7,
          size.height / thirdValue, size.width, size.height / fourthValue)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class WaterAnimationController {
  final List<void Function()> _startListeners = [];
  final List<void Function()> _endListeners = [];

  void Function() addStartEventListner(void Function() listener) {
    _startListeners.add(listener);
    return () {
      _startListeners.remove(listener);
    };
  }

  void Function() addEndEventListner(void Function() listener) {
    _endListeners.add(listener);
    return () {
      _endListeners.remove(listener);
    };
  }

  void start() {
    for (final listener in _startListeners) {
      listener();
    }
  }

  void reset() {
    for (final listener in _endListeners) {
      listener();
    }
  }
}

enum WaterAnimationDirection { up, down }

class WaterAnimation extends HookConsumerWidget {
  const WaterAnimation({
    super.key,
    required this.child,
    required this.direction,
    required this.animation,
    this.duration = const Duration(milliseconds: 4000),
  });

  final Widget child;
  final WaterAnimationDirection direction;
  final Duration duration;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstController =
        useAnimationController(duration: const Duration(milliseconds: 750));
    final secondController =
        useAnimationController(duration: const Duration(milliseconds: 750));
    final thirdController =
        useAnimationController(duration: const Duration(milliseconds: 750));
    final fourthController =
        useAnimationController(duration: const Duration(milliseconds: 750));

    final firstAnimation = useAnimation(Tween<double>(begin: 1.7, end: 2.3)
        .animate(
            CurvedAnimation(parent: firstController, curve: Curves.easeInOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          firstController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          firstController.forward();
        }
      }));

    final secondAnimation = useAnimation(Tween<double>(begin: 1.5, end: 2.6)
        .animate(
            CurvedAnimation(parent: secondController, curve: Curves.easeInOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          secondController.forward();
        }
      }));

    final thirdAnimation = useAnimation(Tween<double>(begin: 1.5, end: 2.6)
        .animate(
            CurvedAnimation(parent: thirdController, curve: Curves.easeInOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          thirdController.forward();
        }
      }));
    final fourthAnimation = useAnimation(Tween<double>(begin: 1.7, end: 2.3)
        .animate(
            CurvedAnimation(parent: fourthController, curve: Curves.easeInOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          fourthController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          fourthController.forward();
        }
      }));

    final heightAnimation = useAnimation(Tween<double>(
                begin: direction == WaterAnimationDirection.up ? 0.0 : 1.0,
                end: direction == WaterAnimationDirection.up ? 1.0 : 0.0)
            .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut))) *
        2;

    final hAnimation = useAnimation<double>(animation.drive(TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 1,
      ),
    ])));

    useEffect(() {
      // final removeAddListener = controller.addStartEventListner(() {
      Timer(const Duration(seconds: 2), () {
        firstController.forward();
      });

      Timer(const Duration(milliseconds: 1600), () {
        secondController.forward();
      });

      Timer(const Duration(milliseconds: 800), () {
        thirdController.forward();
      });

      fourthController.forward();
      return null;

      //     heightController.forward();
      // });

      // final removeEndListener = controller.addEndEventListner(() {
      //   heightController.reset();
      // });

      // return () {
      //   removeAddListener();
      //   removeEndListener();
      // };
    }, []);

    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        child,
        Opacity(
          opacity: min(4 - 2 * heightAnimation, 1),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IgnorePointer(
                  child: CustomPaint(
                    painter: MyPainter(
                      firstAnimation,
                      secondAnimation,
                      thirdAnimation,
                      fourthAnimation,
                    ),
                    child: SizedBox(
                      height: min(max(height * min(1, hAnimation), 0), 200),
                      width: double.infinity,
                    ),
                  ),
                ),
                Container(
                  height: max(height * min(1, hAnimation) - 200, 0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        const Color(0xFF667BFD).withOpacity(0.99),
                        const Color(0xFF2F4CFD).withOpacity(0.99),
                      ],
                      stops: const [
                        0.0,
                        1.0,
                      ],
                    ),
                  ),
                  // color: const Color(0xff3B6ABA).withOpacity(.95),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
