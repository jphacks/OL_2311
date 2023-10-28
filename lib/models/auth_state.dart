import 'package:firebase_auth/firebase_auth.dart';

// NOTE: LoginViewModelで正しく実装できていない可能性が高いため、正常な値が入っていない可能性がある
class AuthState {
  final User? user;
  const AuthState(this.user);
}
