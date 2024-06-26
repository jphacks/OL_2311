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

  AuthViewModel(this._authRepository, this._userRepository)
      : super(AuthState(
          firebaseUser: _authRepository.getCurrentUser(),
          appUser: null, // Initially, appUser is null
        )) {
    _fetchAppUser();
  }

  // getMe()はfirestoreからuserを取得する
  Future<void> _fetchAppUser() async {
    final firebaseUser = _authRepository.getCurrentUser();
    if (firebaseUser != null) {
      final appUser = await _userRepository.getMe();
      state = AuthState(firebaseUser: firebaseUser, appUser: appUser);
    }
  }

  Future<void> signUpWithGoogle() async {
    await _authRepository.signUpWithGoogle();
    await _fetchAppUser();
    // firestoreにuserが存在しない場合は作成する
    final user = await _userRepository.getMe();
    if (user == null) {
      final currentUser = _authRepository.getCurrentUser();
      final newUser = User(
        id: currentUser!.uid,
        username: currentUser.displayName ?? '',
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
