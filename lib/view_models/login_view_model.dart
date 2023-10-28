import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanpai/models/auth_state.dart';
import 'package:kanpai/repositories/auth_repository.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginViewModel(authRepository);
});

class LoginViewModel extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  var _authStateChangesSubscription;

  LoginViewModel(this._authRepository)
      : super(AuthState(_authRepository.firebaseAuth.currentUser)) {
    _authStateChangesSubscription =
        _authRepository.authStateChanges.listen((user) {
      state = AuthState(user);
    });
  }

  Future<void> signUpWithGoogle() async {
    await _authRepository.signUpWithGoogle();
  }

  Future<void> signInWithGoogle() async {
    await _authRepository.signInWithGoogle();
  }

  @override
  void dispose() {
    _authStateChangesSubscription.cancel();
    super.dispose();
  }
}
