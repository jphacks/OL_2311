import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/components/profile_card/profile_card_tag.dart';

class ProfileCard extends HookConsumerWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromRGBO(66, 66, 66, 1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
          image: DecorationImage(
            image: AssetImage("assets/images/card-bg.png"),
            fit: BoxFit.cover,
          )),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildHeader(),
          const Divider(
            height: 1,
          ),
          const SizedBox(
            height: 35,
          ),
          _buildBody(),
          const SizedBox(
            height: 35,
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

  Row _buildFooter() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FaIcon(
          FontAwesomeIcons.instagram,
          color: Colors.white,
          size: 18,
        ),
        SizedBox(
          width: 12,
        ),
        FaIcon(
          FontAwesomeIcons.github,
          color: Colors.white,
          size: 18,
        ),
        SizedBox(
          width: 12,
        ),
        FaIcon(
          FontAwesomeIcons.xTwitter,
          color: Colors.white,
          size: 18,
        ),
      ],
    );
  }

  Row _buildBody() {
    return Row(
      children: [
        Image.asset(
          'assets/images/unlock.png',
          width: 60,
          height: 60,
        ),
        const SizedBox(
          width: 12,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "なまえ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 6,
            ),
            Wrap(
              spacing: 8,
              children: [
                ProfileCardTag(label: "中部"),
                ProfileCardTag(label: "インフラ")
              ],
            )
          ],
        )
      ],
    );
  }
}
