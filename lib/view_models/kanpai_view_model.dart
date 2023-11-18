import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanpai/models/cheer_model.dart';
import 'package:kanpai/models/home_state.dart';
import 'package:kanpai/repositories/cheer_repository.dart';
import 'package:kanpai/repositories/conversation_repository.dart';
import 'package:kanpai/repositories/user_repository.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  final cheerRepository = ref.watch(cheerRepositoryProvider);
  final conversationRepository = ref.watch(conversationRepositoryProvider);
  return HomeViewModel(userRepository, cheerRepository, conversationRepository);
});

class HomeViewModel extends StateNotifier<HomeState> {
  final UserRepository _userRepository;
  final CheerRepository _cheerRepository;
  final ConversationRepository _conversationRepository;

  HomeViewModel(
      this._userRepository, this._cheerRepository, this._conversationRepository)
      : super(HomeState(
            users: const AsyncValue.loading(),
            cheers: const AsyncValue.loading()));

  void updateUsersWithKeywords(String meBleUserId) {
    final updatedUsers = state.users.value?.map((user) {
      final latestCheer = state.cheers.value
          ?.where((cheer) =>
              (cheer.fromUserId == meBleUserId &&
                  cheer.toUserId == user.bleUserId) ||
              (cheer.fromUserId == user.bleUserId &&
                  cheer.toUserId == meBleUserId))
          .toList();

      // latestCheer を timestamp に基づいて降順でソート
      latestCheer?.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      // latestCheer が空の場合は、キーワードを更新せずにそのまま返す
      if (latestCheer == null || latestCheer.isEmpty) {
        return user;
      }

      final latestCheerWithKeywords = latestCheer.firstWhere(
        (cheer) => cheer.keywords != null && cheer.keywords!.isNotEmpty,
        orElse: () => latestCheer.first,
      );

      final keywords = latestCheerWithKeywords.keywords ?? <String>[];
      return user.copyWith(keywords: keywords);
    }).toList();

    if (updatedUsers == null) return;
    state = state.copyWith(users: AsyncValue.data(updatedUsers));
  }

  void fetchUsers() {
    final usersStream = _userRepository.getUsersStream();
    usersStream.listen((users) {
      state = state.copyWith(users: AsyncValue.data(users));
    });
  }

  void fetchCheers(String meBleUserId) {
    final cheersStream = _cheerRepository.getCheersStream();
    cheersStream.listen((cheers) {
      state = state.copyWith(cheers: AsyncValue.data(cheers));
      updateUsersWithKeywords(meBleUserId);
    });
  }

  Future<void> cheers(
    String fromUserId,
    String toBleUserId,
  ) async {
    final fromUser = await _userRepository.getUser(fromUserId);

    final cheerUserIds = fromUser?.cheerUserIds ?? [];
    final newCheerUserIds = [...cheerUserIds, toBleUserId];
    if (fromUser == null) return;
    _userRepository.updateUser(
      fromUserId,
      fromUser.copyWith(
        lastCheersUserId: toBleUserId,
        cheerUserIds: newCheerUserIds,
      ),
    );
    _cheerRepository.createCheer(
      Cheer(
        fromUserId: fromUser.bleUserId!,
        toUserId: toBleUserId,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<List<String>> extractKeywords(
      String conversation, String fromUserId, String toBleUserId) async {
    final keywords =
        await _conversationRepository.extractKeywords(conversation);
    print("keywords: $keywords");

    final fromUser = await _userRepository.getUser(fromUserId);
    if (fromUser == null || fromUser.bleUserId == null) {
      print("fromUserがみつかりません");
      return [];
    }

    final cheerId = await _cheerRepository.getCheerIdByBleUserIds(
        fromUser.bleUserId!, toBleUserId);
    if (cheerId == null) {
      print("cheerIdがみつかりません");
      return [];
    }

    final cheer = await _cheerRepository.getCheer(cheerId);
    if (cheer == null) {
      print("cheerがみつかりません");
      return [];
    }

    await _cheerRepository.updateCheer(
      cheerId,
      cheer.copyWith(
        keywords: keywords,
      ),
    );

    print("firestoreにkeywordsを保存しました");

    return keywords;
  }
}
