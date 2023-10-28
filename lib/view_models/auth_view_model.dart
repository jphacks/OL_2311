import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanpai/models/auth_state.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/repositories/auth_repository.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthViewModel(authRepository);
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  var _authStateChangesSubscription;

  // TODO: この辺りのロジックは正しく実装できていない可能性が高い
  AuthViewModel(this._authRepository)
      : super(AuthState(_authRepository.firebaseAuth.currentUser)) {
    _authStateChangesSubscription =
        _authRepository.authStateChanges.listen((user) {
      state = AuthState(user);
    });
  }

  Future<User?> fetchCurrentUser() async {
    return await _authRepository.getCurrentUser();
  }

  Future<void> signUpWithGoogle() async {
    await _authRepository.signUpWithGoogle();
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
