import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/repositories/user_repository.dart';

final question3ViewModelProvider =
    StateNotifierProvider<Question3ViewModel, AsyncValue<List<User>>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return Question3ViewModel(userRepository);
});

class Question3ViewModel extends StateNotifier<AsyncValue<List<User>>> {
  final UserRepository _userRepository;

  Question3ViewModel(this._userRepository) : super(const AsyncValue.loading());

  void updateMe(String xId, String instagramId, String homepageLink) async {
    final user = await _userRepository.getMe();
    if (user == null) return;

    _userRepository.updateUser(
      user.id,
      user.copyWith(
        xId: xId,
        instagramId: instagramId,
        homepageLink: homepageLink,
      ),
    );
  }
}
