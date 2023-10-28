import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  return AuthRepository(firebaseAuth, googleSignIn);
});

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRepository(this.firebaseAuth, this.googleSignIn);

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<void> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
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
}
