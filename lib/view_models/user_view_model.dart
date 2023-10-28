import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/repositories/user_repository.dart';

class UserListViewModel extends StateNotifier<AsyncValue<List<User>>> {
  final UserRepository _userRepository;

  UserListViewModel(this._userRepository) : super(const AsyncValue.loading()) {
    _fetchUsers();
  }

  void _fetchUsers() {
    final usersStream = _userRepository.getUsers();
    usersStream.listen((users) {
      state = AsyncValue.data(users);
    });
  }
}
