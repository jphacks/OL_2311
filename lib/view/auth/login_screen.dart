import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/view/auth/ble_config_screen.dart';
import 'package:kanpai/view/onboarding/profile_screen/profile_screen.dart';
import 'package:kanpai/view_models/auth_view_model.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginViewModel = ref.watch(authViewModelProvider.notifier);

    final appbar = AppBar(
      title: const Text("ログイン"),
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const BleConfigScreen(),
            );
          },
          icon: const Icon(
            Icons.settings,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 10),
      ],
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
                          await loginViewModel.signUpWithGoogle();
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
              ]),
        ));
  }
}
