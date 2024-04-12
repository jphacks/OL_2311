import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kanpai/view/onboarding/onboarding_layout.dart';
import 'package:kanpai/view/onboarding/profile_screen/components/profile_avatar.dart';
import 'package:kanpai/view/onboarding/profile_screen/components/profile_form.dart';
import 'package:kanpai/view/onboarding/question1_screen/question1_screen.dart';
import 'package:kanpai/view_models/profile_view_model.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileViewModel = ref.read(profileViewModelProvider.notifier);
    final profileState = ref.watch(profileViewModelProvider);
    final firebaseUser = FirebaseAuth.instance.currentUser!;

    final initialProfileImage =
        profileState.profileImageUrl ?? firebaseUser.photoURL;
    final customProfileImage = useState<File?>(null);

    final usernameController =
        useTextEditingController(text: profileState.username);
    final bioController = useTextEditingController(text: profileState.bio);

    useEffect(() {
      usernameController.text = profileState.username ?? '';
      bioController.text = profileState.bio ?? '';
      return null;
    }, [profileState.username, profileState.bio]);

    Future<void> pickImage(ImageSource source) async {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        customProfileImage.value = File(pickedFile.path);
      }
    }

    return OnboardingLayout(
      title: "プロフィールはこちらで\nよろしいですか？",
      indicator: 1,
      loading: profileState.isLoading,
      onNextPressed: () async {
        await profileViewModel
            .updateProfile(
              usernameController.text,
              customProfileImage.value,
              bioController.text,
            )
            .then((value) => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const Question1Screen(),
                  ),
                ));
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProfileAvatar(
              initialProfileImage: initialProfileImage,
              profileImage: customProfileImage.value,
              onPickImage: pickImage,
            ),
            const SizedBox(height: 40),
            ProfileForm(
              usernameController: usernameController,
              bioController: bioController,
            ),
          ],
        ),
      ),
    );
  }
}
