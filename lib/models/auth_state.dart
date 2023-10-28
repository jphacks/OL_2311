import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanpai/models/user_model.dart' as model;

class AuthState {
  final User? firebaseUser;
  final model.User? appUser;

  AuthState({
    required this.firebaseUser,
    required this.appUser,
  });
}
