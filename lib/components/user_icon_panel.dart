import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/models/user_model.dart';

class UserIconPanel extends HookConsumerWidget {
  const UserIconPanel({
    super.key,
    required this.user,
    required this.count,
  });

  final User user;
  final int count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUnlocked = 0 < count;

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
            child: isUnlocked
                ? CircleAvatar(
                    radius: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: Image.network(user.profileImageUrl!),
                    ),
                  )
                : Image.asset(
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
                  user.name!,
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
