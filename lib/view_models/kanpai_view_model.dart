import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/repositories/user_repository.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, AsyncValue<List<User>>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return HomeViewModel(userRepository);
});

class HomeViewModel extends StateNotifier<AsyncValue<List<User>>> {
  final UserRepository _userRepository;

  HomeViewModel(this._userRepository) : super(const AsyncValue.loading());

  void fetchUsers() {
    final usersStream = _userRepository.getUsersStream();
    usersStream.listen((users) {
      state = AsyncValue.data(users);
    });
  }

  void cheers(
    String fromUserId,
    String toUserId,
  ) async {
    final user = await _userRepository.getUser(fromUserId);
    final cheerUserIds = user?.cheerUserIds ?? [];
    cheerUserIds.add(toUserId);
    if (user == null) return;
    _userRepository.updateUser(
      fromUserId,
      user.copyWith(
        lastCheersUserId: toUserId,
        cheerUserIds: cheerUserIds,
      ),
    );
  }
}
