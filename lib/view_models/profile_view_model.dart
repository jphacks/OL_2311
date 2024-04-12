import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/models/ui/profile_state.dart';
import 'package:kanpai/models/user_model.dart' as kanpai_user;
import 'package:kanpai/repositories/auth_repository.dart';
import 'package:kanpai/repositories/user_repository.dart';

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, ProfileState>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  final me = ref.watch(meProvider).value;
  return ProfileViewModel(ProfileState.initial(me), me, userRepository);
});

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel(ProfileState state, this._me, this._userRepository)
      : super(state);

  final kanpai_user.User? _me;
  final UserRepository _userRepository;

  Future<void> updateProfile(
    String? username,
    File? customProfileImage,
    String? bio,
  ) async {
    state = state.copyWith(isLoading: true);

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      state = state.copyWith(isLoading: false);
      return;
    }

    if (_me == null) {
      state = state.copyWith(isLoading: false);
      return;
    }

    bool hasChanges = false;
    String? profileImageUrl = _me?.profileImageUrl;
    String? customProfileImageUrl;

    if (customProfileImage != null) {
      final storageRef =
          FirebaseStorage.instance.ref().child('profile_images/${user.uid}');
      final uploadTask = storageRef.putFile(customProfileImage);
      final snapshot = await uploadTask.whenComplete(() {});
      customProfileImageUrl = await snapshot.ref.getDownloadURL();
      profileImageUrl = customProfileImageUrl;
      hasChanges = true;
    }

    if (username != _me?.username) {
      hasChanges = true;
    }

    if (bio != _me?.bio) {
      hasChanges = true;
    }

    if (hasChanges) {
      final updateTasks = [
        // NOTE: FirebaseのAUthの情報は使わないため、最新の状態に更新しない
        // user.updateDisplayName(username),
        // user.updatePhotoURL(customProfileImageUrl),
        _userRepository.updateUser(
          user.uid,
          _me!.copyWith(
            username: username,
            profileImageUrl: profileImageUrl,
            bio: bio,
          ),
        ),
      ];

      await Future.wait(updateTasks);
    }

    state = state.copyWith(
      username: username,
      bio: bio,
      profileImageUrl: profileImageUrl,
      isLoading: false,
    );
  }
}
