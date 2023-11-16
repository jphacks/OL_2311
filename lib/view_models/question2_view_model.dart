import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanpai/repositories/user_repository.dart';
import 'package:kanpai/view/onboarding/question2_screen/tech_area.dart';

final question2ViewModelProvider =
    StateNotifierProvider<Question2ViewModel, AsyncValue<TechArea?>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return Question2ViewModel(userRepository);
});

class Question2ViewModel extends StateNotifier<AsyncValue<TechArea>> {
  final UserRepository _userRepository;

  Question2ViewModel(this._userRepository) : super(const AsyncValue.loading());

  void updateMe(String techArea) async {
    final user = await _userRepository.getMe();
    if (user == null) return;

    state = AsyncData(TechArea.fromName(techArea));

    print(state);

    _userRepository.updateUser(
      user.id,
      user.copyWith(techArea: techArea),
    );
  }
}
