import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/components/profile_card/icon_chip.dart';
import 'package:kanpai/components/profile_card/sns_button.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/util/format_time.dart';
import 'package:kanpai/util/get_user_color.dart';

class ProfileCard extends HookConsumerWidget {
  ProfileCard({super.key, required this.user, this.hasBottomPadding = false})
      : tags = user == null ? [] : [user.location!, user.techArea!];

  final User? user;
  final bool hasBottomPadding;

  final List<String> tags;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final techAreaStruct = TechAreaStruct.fromText(user?.techArea);

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(66, 66, 66, 1),
        border: Border.all(
          color: Colors.white.withOpacity(0.8),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        image: const DecorationImage(
          image: AssetImage("assets/images/bg-effect-cup.png"),
          fit: BoxFit.cover,
        ),
        gradient: RadialGradient(
          radius: 1,
          colors: [
            techAreaStruct.cardBgGradientBegin,
            techAreaStruct.cardBgGradientEnd
          ],
        ),
      ),
      child: Column(
        children: [
          _buildHeader(techAreaStruct.solidBgColor),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: _buildBody(techAreaStruct.ringImage),
          ),
          if (hasBottomPadding) const SizedBox(height: 20),
        ],
      ),
    );
  }

  Container _buildHeader(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          const Text(
            "直近の ",
            style: TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SvgPicture.asset(
            "assets/svgs/kanpai-logo.svg",
            height: 20,
            theme: const SvgTheme(currentColor: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(String ringImageUrl) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (user != null)
              IconChip(
                imageUrl: user!.profileImageUrl!,
                ringImageUrl: ringImageUrl,
              )
            else
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(999)),
              ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: user == null
                  ? [
                      const Text(
                        "まだ見ぬだれか",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ]
                  : [
                      Text(
                        user!.name!,
                        style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formatDateTime(DateTime.now()),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        spacing: 8,
                        children: tags
                            .map((tag) => Text("#$tag",
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold)))
                            .toList(),
                      )
                    ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        if (user != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SnsButton(
                  url: "https://www.instagram.com/${user!.instagramId}",
                  icon: FontAwesomeIcons.instagram),
              const SizedBox(
                width: 12,
              ),
              const SnsButton(
                  // TODO: githubアカウント
                  url: "https://github.com",
                  icon: FontAwesomeIcons.github),
              const SizedBox(
                width: 12,
              ),
              SnsButton(
                  url: "https://twitter.com/${user!.xId}",
                  icon: FontAwesomeIcons.xTwitter),
            ],
          )
      ],
    );
  }
}
