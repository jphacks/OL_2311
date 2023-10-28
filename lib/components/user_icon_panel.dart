import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserIconPanel extends HookConsumerWidget {
  const UserIconPanel({
    super.key,
    required this.isUnlocked,
    required this.count,
  });

  final bool isUnlocked;
  final int count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.20),
        ),
        gradient: const LinearGradient(
          begin: Alignment(0, -1),
          end: Alignment(0, 1),
          colors: [Colors.white, Color(0xFFEAEAEA)],
          stops: [
            0.0,
            1.0,
          ],
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F999999),
            blurRadius: 6,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            child: Image.asset(
              "assets/images/unlock.png",
              width: 80,
              height: 80,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xffE8E8E8),
            child: Column(
              children: [
                Text(
                  "まろすけ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xff2A2A2A),
                      borderRadius: BorderRadius.all(Radius.circular(999))),
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/svgs/cup.svg",
                        height: 12,
                        theme: const SvgTheme(currentColor: Colors.white),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "$count",
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
