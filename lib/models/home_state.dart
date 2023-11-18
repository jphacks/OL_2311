import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/models/cheer_model.dart';
import 'package:kanpai/models/user_model.dart';

class HomeState {
  final AsyncValue<List<User>> users;
  final AsyncValue<List<Cheer>> cheers;

  HomeState({required this.users, required this.cheers});

  // コピーを作成するためのメソッド
  HomeState copyWith({
    AsyncValue<List<User>>? users,
    AsyncValue<List<Cheer>>? cheers,
  }) {
    return HomeState(
      users: users ?? this.users,
      cheers: cheers ?? this.cheers,
    );
  }
}
