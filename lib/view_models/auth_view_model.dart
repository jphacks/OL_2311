import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanpai/models/auth_state.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/repositories/auth_repository.dart';
import 'package:kanpai/repositories/user_repository.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  return AuthViewModel(authRepository, userRepository);
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  var _authStateChangesSubscription;

  // TODO: この辺りのロジックは正しく実装できていない可能性が高い
  AuthViewModel(this._authRepository, this._userRepository)
      : super(AuthState(_authRepository.getCurrentUser())) {
    _authStateChangesSubscription =
        _authRepository.authStateChanges.listen((user) {
      state = AuthState(user);
    });
  }

  // getMe()はfirestoreからuserを取得する
  Future<User?> fetchMe() async {
    return _userRepository.getMe();
  }

  Future<void> signUpWithGoogle() async {
    await _authRepository.signUpWithGoogle();
    // firestoreにuserが存在しない場合は作成する
    final user = await _userRepository.getMe();
    if (user == null) {
      final currentUser = _authRepository.getCurrentUser();
      final newUser = User(
        id: currentUser!.uid,
        name: currentUser.displayName ?? '',
        profileImageUrl: currentUser.photoURL ?? '',
      );
      await _userRepository.createUser(newUser);
    }
  }

  Future<void> signInWithGoogle() async {
    await _authRepository.signInWithGoogle();
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  @override
  void dispose() {
    _authStateChangesSubscription.cancel();
    super.dispose();
  }
}
