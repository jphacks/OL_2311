import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanpai/models/auth_state.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/repositories/auth_repository.dart';
import 'package:kanpai/repositories/user_repository.dart';
import 'package:kanpai/util/string.dart';

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

  Future<String> _generateUniqueBleUserId() async {
    String bleUserId = 'hogehoge';
    bool isUnique = false;
    while (!isUnique) {
      bleUserId = StringUtils.generateRandomString(6);
      isUnique = await _userRepository.isUniqueBleUserId(bleUserId);
    }
    return bleUserId;
  }

  Future<String?> signUpWithGoogle() async {
    await _authRepository.signUpWithGoogle();
    await _fetchAppUser();
    // firestoreにuserが存在しない場合は作成する
    final user = await _userRepository.getMe();
    final bleUserId = await _generateUniqueBleUserId();
    if (user == null) {
      final currentUser = _authRepository.getCurrentUser();
      final newUser = User(
        id: currentUser!.uid,
        name: currentUser.displayName ?? '',
        profileImageUrl: currentUser.photoURL ?? '',
        bleUserId: bleUserId,
      );
      await _userRepository.createUser(newUser);
      return currentUser.uid;
    }
    return null;
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
