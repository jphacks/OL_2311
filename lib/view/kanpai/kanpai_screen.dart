import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/components/profile_card/profile_card.dart';

class KanpaiScreen extends HookConsumerWidget {
  const KanpaiScreen({super.key});
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
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.account_circle_outlined,
            color: Colors.white,
          ),
        )
      ],
    );

    return Scaffold(
        appBar: appbar,
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/kanpai-bg-blue.png"),
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter)),
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 320,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("乾杯した総回数",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              height: 1,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 16),
                      const Text("23",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 54,
                              fontFamily: "Chillax",
                              height: 1,
                              fontWeight: FontWeight.w600)),
                      SvgPicture.asset(
                        "assets/svgs/kanpai-logo.svg",
                        height: 28,
                        theme: const SvgTheme(currentColor: Colors.white),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ProfileCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
