import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/view/onboarding/question1_screen/question1_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appbar = AppBar(
      title: const Text("ログイン"),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );

    return Scaffold(
        appBar: appbar,
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        body: Padding(
          padding: EdgeInsets.only(
              top: 32 + appbar.preferredSize.height,
              left: 32,
              right: 32,
              bottom: 32),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "プロフィールはこちらで\nよろしいですか？",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                CircleAvatar(
                    radius: 50.0, // 円形アバターの半径
                    backgroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser!.photoURL!)),
                Text(
                  "github ID : 03840_kanpai ",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const Question1Screen()));
                        },
                        child: const Text(
                          "次へ",
                        ))),
              ]),
        ));
  }
}
