import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/repositories/user_repository.dart';

final question1ViewModelProvider =
    StateNotifierProvider<Question1ViewModel, AsyncValue<List<User>>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return Question1ViewModel(userRepository);
});

class Question1ViewModel extends StateNotifier<AsyncValue<List<User>>> {
  final UserRepository _userRepository;

  Question1ViewModel(this._userRepository) : super(const AsyncValue.loading());

  void updateMe(String location) async {
    final user = await _userRepository.getMe();
    if (user == null) return;

    _userRepository.updateUser(
      user.id,
      user.copyWith(location: location),
    );
  }
}
