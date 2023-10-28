import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/components/form_item.dart';
import 'package:kanpai/view/onboarding/onboarding_layout.dart';
import 'package:kanpai/view/onboarding/question1_screen/question1_screen.dart';
import 'package:kanpai/view_models/profile_view_model.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileViewModel = ref.watch(profileViewModelProvider.notifier);
    final displayName = FirebaseAuth.instance.currentUser!.displayName;

    final nameController = useTextEditingController(text: displayName);

    return OnboardingLayout(
      title: "プロフィールはこちらで\nよろしいですか？",
      onNextPressed: () {
        // TODO: 画像を更新できるようにする
        ProfileViewModel.updateMe(
            nameController.text, FirebaseAuth.instance.currentUser!.photoURL!);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const Question1Screen()));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser!.photoURL!)),
                Positioned(
                  bottom: -8,
                  right: -8,
                  child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0xffE0E0E0), width: 1),
                          borderRadius: BorderRadius.circular(999)),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 18,
                      )),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            // TODO: 正しい値を入れる
            "Google ID : 03840_kanpai",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(
            height: 32,
          ),
          FormItem(
              label: "名前",
              helperText: "乾杯する相手に表示される名前です",
              controller: nameController),
        ],
      ),
    );
  }
}
