import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/main.dart';
import 'package:kanpai/view/auth/ble_config_screen.dart';
import 'package:kanpai/view/onboarding/profile_screen/profile_screen.dart';
import 'package:kanpai/view/tutorial/tutorial_screen.dart';
import 'package:kanpai/view_models/auth_view_model.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appbar = AppBar(
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
          padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 256),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svgs/main-visual.svg",
                        width: 196,
                        theme: const SvgTheme(currentColor: Color(0xff010103)),
                      ),
                      SvgPicture.asset(
                        "assets/svgs/kanpai-logo.svg",
                        width: 132,
                        theme: const SvgTheme(currentColor: Color(0xff010103)),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildGoogleLoginButton(context, ref),
                    const SizedBox(
                      height: 24,
                    ),
                    _buildGitHubLoginButton(context, ref),
                    const SizedBox(
                      height: 12,
                    ),
                    const _buildTutorialButton()
                  ],
                ),
              )
            ],
          ),
        ));
  }

  SizedBox _buildGitHubLoginButton(BuildContext context, WidgetRef ref) {
    final loginViewModel = ref.watch(authViewModelProvider.notifier);

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
          onPressed: () async {
            // TODO: GitHubログインに変更
            await loginViewModel.signUpWithGoogle();
            if (!context.mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          },
          icon: const FaIcon(
            FontAwesomeIcons.github,
            size: 20,
          ),
          label: const Text(
            "GitHub アカウントでログイン",
            style: TextStyle(fontSize: 15),
          )),
    );
  }

  SizedBox _buildGoogleLoginButton(BuildContext context, WidgetRef ref) {
    final loginViewModel = ref.watch(authViewModelProvider.notifier);
    final prefs = ref.watch(sharedPreferencesProvider);

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                  side: const BorderSide(
                    color: Colors.black87,
                  ))),
              overlayColor: MaterialStateProperty.all(Colors.black12),
              foregroundColor: MaterialStateProperty.all(Colors.black87),
              backgroundColor: MaterialStateProperty.all(Colors.transparent)),
          onPressed: () async {
            final bleUserId = await loginViewModel.signUpWithGoogle();
            if (bleUserId != null) {
              await prefs.setString("bleUserId", bleUserId);
            }
            if (!context.mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Tutorial1Screen()),
            );
          },
          icon: const FaIcon(
            FontAwesomeIcons.google,
            size: 18,
          ),
          label: const Text(
            "Googleアカウントでログイン",
            style: TextStyle(fontSize: 15),
          )),
    );
  }
}

class _buildTutorialButton extends StatelessWidget {
  const _buildTutorialButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const Tutorial1Screen(),
                fullscreenDialog: true),
          );
        },
        child: const Text(
          "チュートリアル",
          style: TextStyle(color: Colors.black54),
        ));
  }
}
