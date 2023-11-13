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
      ..color = const Color.fromARGB(255, 89, 106, 235).withOpacity(0.95)
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

  start() {
    for (final listener in _startListeners) {
      listener();
    }
  }

  reset() {
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
    required this.controller,
    required this.direction,
    this.duration = const Duration(milliseconds: 5000),
  });

  final Widget child;
  final WaterAnimationController controller;
  final WaterAnimationDirection direction;
  final Duration duration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heightController = useAnimationController(duration: duration);

    final firstController =
        useAnimationController(duration: const Duration(milliseconds: 1500));
    final secondController =
        useAnimationController(duration: const Duration(milliseconds: 1500));
    final thirdController =
        useAnimationController(duration: const Duration(milliseconds: 1500));
    final fourthController =
        useAnimationController(duration: const Duration(milliseconds: 1500));

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
        .animate(CurvedAnimation(
            parent: heightController, curve: Curves.easeInOut)));

    useEffect(() {
      final removeAddListener = controller.addStartEventListner(() {
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

        heightController.forward();
      });

      final removeEndListener = controller.addEndEventListner(() {
        heightController.reset();
      });

      return () {
        removeAddListener();
        removeEndListener();
      };
    }, []);

    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        child,
        Align(
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
                    height: min(max(height * heightAnimation, 0), 200),
                    width: double.infinity,
                  ),
                ),
              ),
              Container(
                height: max(height * heightAnimation - 200, 0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      const Color.fromARGB(255, 89, 106, 235).withOpacity(0.95),
                      const Color.fromARGB(255, 170, 112, 211)
                          .withOpacity(0.95),
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
      ],
    );
  }
}
