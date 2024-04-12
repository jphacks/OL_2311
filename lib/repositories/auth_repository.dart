import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/models/user_model.dart' as kanpai_user;
import 'package:kanpai/repositories/user_repository.dart';

final meProvider = StreamProvider<kanpai_user.User>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userRepository = ref.watch(userRepositoryProvider);

  return authRepository.authStateChanges.asyncMap((User? firebaseUser) async {
    if (firebaseUser == null) {
      throw Exception('User is not authenticated');
    }

    final dbMe = await userRepository.getMe();
    if (dbMe != null) {
      return dbMe;
    }

    return kanpai_user.User(
      id: firebaseUser.uid,
      username: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? '',
      bio: null,
      profileImageUrl: firebaseUser.photoURL,
    );
  });
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  return AuthRepository(
    firebaseAuth,
    googleSignIn,
  );
});

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository(
    this._firebaseAuth,
    this._googleSignIn,
  );

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signUpWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return; // The user canceled the sign-in process

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signInWithGoogle() async {
    await signUpWithGoogle(); // In Google Auth, sign-in and sign-up are the same.
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Stream<User?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().asyncMap((user) async {
      return user;
    });
  }
}
