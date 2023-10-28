import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/repositories/user_repository.dart';

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, AsyncValue<List<User>>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return ProfileViewModel(userRepository);
});

class ProfileViewModel extends StateNotifier<AsyncValue<List<User>>> {
  final UserRepository _userRepository;

  ProfileViewModel(this._userRepository) : super(const AsyncValue.loading());

  void updateMe(String name, String? profileImageUrl) async {
    final user = await _userRepository.getMe();
    if (user == null) return;

    _userRepository.updateUser(
      user.id,
      user.copyWith(
        name: name,
        profileImageUrl: profileImageUrl,
      ),
    );
  }
}
