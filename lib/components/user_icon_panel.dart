import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/components/profile_card/icon_chip.dart';
import 'package:kanpai/components/tag.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/util/get_user_color.dart';

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

    final techAreaStruct = TechAreaStruct.fromText(user.techArea);

    return DottedBorder(
      padding: const EdgeInsets.all(1),
      borderType: BorderType.RRect,
      color: isUnlocked ? Colors.transparent : const Color(0xffBDBDBD),
      radius: const Radius.circular(20),
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: isUnlocked ? null : Colors.white,
          boxShadow: isUnlocked
              ? [
                  const BoxShadow(
                    color: Color(0x3F999999),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: isUnlocked
                    ? DecorationImage(
                        image: AssetImage(techAreaStruct.panelBgImage),
                        fit: BoxFit.fitWidth,
                      )
                    : null,
              ),
              child: SizedBox(
                  height: 128,
                  child: isUnlocked
                      ? IconChip(
                          imageUrl: user.profileImageUrl!,
                          ringImageUrl: techAreaStruct.ringImage,
                          size: IconChipSize.lg)
                      : Center(
                          child: Image.asset(
                            techAreaStruct.lockImage,
                            width: 88,
                            height: 88,
                          ),
                        )),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: isUnlocked
                    ? LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          techAreaStruct.panelUnderTextBgGradientBegin,
                          techAreaStruct.panelUnderTextBgGradientEnd,
                        ],
                        stops: const [
                          0.0,
                          1.0,
                        ],
                      )
                    : null,
                color: isUnlocked ? null : const Color(0xffEEEEEE),
              ),
              child: Column(
                children: [
                  Text(
                    isUnlocked ? user.name! : "? ? ?",
                    style: const TextStyle(
                        fontFamily: "Kollektif_sub",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Tag(
                      label: user.techArea!,
                      color: isUnlocked
                          ? techAreaStruct.solidBgColor
                          : const Color(0xFFBDBDBD))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
