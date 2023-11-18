import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanpai/repositories/user_repository.dart';
import 'package:kanpai/util/get_user_color.dart';
import 'package:kanpai/util/string.dart';
import 'package:kanpai/view/onboarding/question2_screen/tech_area.dart';

final question2ViewModelProvider =
    StateNotifierProvider<Question2ViewModel, AsyncValue<TechArea?>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return Question2ViewModel(userRepository);
});

class Question2ViewModel extends StateNotifier<AsyncValue<TechArea>> {
  final UserRepository _userRepository;

  Question2ViewModel(this._userRepository) : super(const AsyncValue.loading());

  Future<String> generateUniqueBleUserId() async {
    String bleUserId = '';
    bool isUnique = false;
    while (!isUnique) {
      bleUserId = StringUtils.generateRandomString(5);
      isUnique = await _userRepository.isUniqueBleUserId(bleUserId);
    }
    return bleUserId;
  }

  Future<String> updateMe(String techArea) async {
    final user = await _userRepository.getMe();

    if (user == null) return "";

    state = AsyncData(TechArea.fromName(techArea));

    var bleUserId = TechAreaStruct.fromText(techArea).prefix;
    bleUserId += await generateUniqueBleUserId();

    print("bleUserId: $bleUserId");

    await _userRepository.updateUserWithBleUserId(
      user.id,
      bleUserId,
      user.copyWith(techArea: techArea),
    );

    return bleUserId;
  }
}
