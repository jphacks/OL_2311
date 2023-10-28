import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/models/user_model.dart' as model;

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final db = FirebaseFirestore.instance;
  return AuthRepository(firebaseAuth, googleSignIn, db);
});

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _db;

  AuthRepository(this.firebaseAuth, this._googleSignIn, this._db);

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<void> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // The user canceled the sign-in process

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await firebaseAuth.signInWithCredential(credential);
    } catch (error) {
      print('Sign up with Google failed: $error');
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    await signUpWithGoogle(); // In Google Auth, sign-in and sign-up are the same.
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<model.User?> getCurrentUser() async {
    final User? user = firebaseAuth.currentUser;
    try {
      final dbUser = await _db.collection('users').doc(user?.uid).get();
      return model.User.fromJson(dbUser.data()!);
    } catch (e) {
      print('Failed to fetch user info: $e');
    }
    return null;
  }

  Stream<model.User?> get onAuthStateChanged {
    return firebaseAuth.authStateChanges().asyncMap((user) async {
      if (user != null) {
        try {
          final dbUser = await _db.collection('users').doc(user.uid).get();
          if (dbUser.exists) {
            return model.User.fromJson(dbUser.data()!);
          }
        } catch (e) {
          print('Failed to fetch user info: $e');
        }
      }
      return null;
    });
  }
}
