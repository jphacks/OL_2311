import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/components/profile_card/profile_card_tag.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:url_launcher/link.dart';

class ProfileCard extends HookConsumerWidget {
  const ProfileCard({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(66, 66, 66, 1),
        borderRadius: BorderRadius.all(Radius.circular(12)),
        image: DecorationImage(
          image: AssetImage("assets/images/card-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildHeader(),
          const Divider(
            height: 1,
          ),
          SizedBox(
            height: user == null ? 25 : 35,
          ),
          _buildBody(),
          SizedBox(
            height: user == null ? 25 : 35,
          ),
          _buildFooter()
        ],
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Text(
                "直近の ",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset(
                "assets/svgs/kanpai-logo.svg",
                height: 24,
                theme: const SvgTheme(currentColor: Colors.white),
              ),
            ],
          ),
          if (user != null)
            Text(
              "10/29 14:55",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    if (user == null) {
      return Wrap(
        runSpacing: 6,
        children: [
          const Text(
            "まだ ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          SvgPicture.asset(
            "assets/svgs/kanpai-logo.svg",
            height: 20,
            theme: const SvgTheme(currentColor: Colors.white),
          ),
          const Text(
            " した人がいません。近くの人と ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          SvgPicture.asset(
            "assets/svgs/kanpai-logo.svg",
            height: 20,
            theme: const SvgTheme(currentColor: Colors.white),
          ),
          const Text(
            " してみましょう！",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Link(
            uri: Uri.parse("https://www.instagram.com/${user!.instagramId}"),
            builder: (BuildContext context, FollowLink? followLink) => InkWell(
                  onTap: followLink,
                  child: const FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Colors.white,
                    size: 18,
                  ),
                )),
        const SizedBox(
          width: 12,
        ),
        Link(
            // TODO: githubアカウント
            uri: Uri.parse("https://github.com"),
            builder: (BuildContext context, FollowLink? followLink) => InkWell(
                  onTap: followLink,
                  child: const FaIcon(
                    FontAwesomeIcons.github,
                    color: Colors.white,
                    size: 18,
                  ),
                )),
        const SizedBox(
          width: 12,
        ),
        Link(
          uri: Uri.parse("https://twitter.com/${user!.xId}"),
          builder: (BuildContext context, FollowLink? followLink) => InkWell(
            onTap: followLink,
            child: const FaIcon(
              FontAwesomeIcons.xTwitter,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  Row _buildBody() {
    return Row(
      children: [
        if (user != null)
          CircleAvatar(
              radius: 30, backgroundImage: NetworkImage(user!.profileImageUrl!))
        else
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(999)),
          ),
        const SizedBox(
          width: 12,
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
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Wrap(
                    spacing: 8,
                    children: [
                      ProfileCardTag(label: user!.location!),
                      ProfileCardTag(label: user!.techArea!)
                    ],
                  )
                ],
        )
      ],
    );
  }
}
