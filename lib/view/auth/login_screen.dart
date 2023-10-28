import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/auth/login.dart';
import 'package:kanpai/view/onboarding/connect_screen/connect_screen.dart';
import 'package:kanpai/view/onboarding/profile_screen/profile_screen.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

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
                  "ログインページ",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    if (!context.mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ConnectScreen()),
                    );
                  },
                  child: const Text(
                    "ペアリング",
                  ),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                      onPressed: () async {
                        await signInWithGoogle();
                        if (!context.mounted) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ProfileScreen()),
                        );
                      },
                      child: const Text(
                        "ログイン",
                      ))),
            ],
          ),
        ));
  }
}
