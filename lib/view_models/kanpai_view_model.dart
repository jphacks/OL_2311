import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanpai/models/cheer_model.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/repositories/cheer_repository.dart';
import 'package:kanpai/repositories/user_repository.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, AsyncValue<List<User>>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  final cheerRepository = ref.watch(cheerRepositoryProvider);
  return HomeViewModel(userRepository, cheerRepository);
});

class HomeViewModel extends StateNotifier<AsyncValue<List<User>>> {
  final UserRepository _userRepository;
  final CheerRepository _cheerRepository;

  HomeViewModel(this._userRepository, this._cheerRepository)
      : super(const AsyncValue.loading());

  void fetchUsers() {
    final usersStream = _userRepository.getUsersStream();
    usersStream.listen((users) {
      state = AsyncValue.data(users);
    });
  }

  Future<void> cheers(
    String fromUserId,
    String toUserId,
  ) async {
    final user = await _userRepository.getUser(fromUserId);
    final cheerUserIds = user?.cheerUserIds ?? [];
    final newCheerUserIds = [...cheerUserIds, toUserId];
    if (user == null) return;
    _userRepository.updateUser(
      fromUserId,
      user.copyWith(
        lastCheersUserId: toUserId,
        cheerUserIds: newCheerUserIds,
      ),
    );
    _cheerRepository.createCheer(
      Cheer(
        fromUserId: fromUserId,
        toUserId: toUserId,
      ),
    );
  }
}
