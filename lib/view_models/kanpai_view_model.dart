import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanpai/models/cheer_model.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/repositories/cheer_repository.dart';
import 'package:kanpai/repositories/conversation_repository.dart';
import 'package:kanpai/repositories/user_repository.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, AsyncValue<List<User>>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  final cheerRepository = ref.watch(cheerRepositoryProvider);
  final conversationRepository = ref.watch(conversationRepositoryProvider);
  return HomeViewModel(userRepository, cheerRepository, conversationRepository);
});

class HomeViewModel extends StateNotifier<AsyncValue<List<User>>> {
  final UserRepository _userRepository;
  final CheerRepository _cheerRepository;
  final ConversationRepository _conversationRepository;

  HomeViewModel(
      this._userRepository, this._cheerRepository, this._conversationRepository)
      : super(const AsyncValue.loading());

  void fetchUsers() {
    final usersStream = _userRepository.getUsersStream();
    usersStream.listen((users) {
      state = AsyncValue.data(users);
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
        fromUserId: fromUserId,
        toUserId: toBleUserId,
      ),
    );
  }

  Future<List<String>> extractKeywords(
      String conversation, String fromUserId, String toBleUserId) async {
    final keywords =
        await _conversationRepository.extractKeywords(conversation);
    print("keywords: $keywords");

    final toUserId = await _userRepository.getUserIdByBleUserId(toBleUserId);
    if (toUserId == null) {
      print("toUserIdがみつかりません");
      return [];
    }

    final cheerId = await _cheerRepository.getCheerIdByFromUserIdAndToUserId(
        fromUserId, toUserId);
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
