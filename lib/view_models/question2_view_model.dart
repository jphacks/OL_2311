import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/repositories/user_repository.dart';

final question2ViewModelProvider =
    StateNotifierProvider<Question2ViewModel, AsyncValue<List<User>>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return Question2ViewModel(userRepository);
});

class Question2ViewModel extends StateNotifier<AsyncValue<List<User>>> {
  final UserRepository _userRepository;

  Question2ViewModel(this._userRepository) : super(const AsyncValue.loading());

  void updateMe(String techArea) async {
    final user = await _userRepository.getMe();
    if (user == null) return;

    _userRepository.updateUser(
      user.id,
      user.copyWith(techArea: techArea),
    );
  }
}
