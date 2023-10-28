import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/repositories/auth_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final db = FirebaseFirestore.instance;
  final authRepository = ref.watch(authRepositoryProvider);
  return UserRepository(db, authRepository);
});

class UserRepository {
  final FirebaseFirestore _db;
  final AuthRepository _authRepository;

  UserRepository(this._db, this._authRepository);

  Stream<List<User>> getUsersStream() {
    return _db.collection('users').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => User.fromJson(doc.data()..addAll({"id": doc.id})))
        .toList()); // snapshot.docsをUserに変換
  }

  Future<User?> getUser(String userId) async {
    final res = await _db.collection('users').doc(userId).get();
    print(res.data());
    if (res.data() == null) return null;
    return User.fromJson(res.data()!..addAll({"id": userId}));
  }

  Future<User?> getMe() async {
    final currentUser = _authRepository.getCurrentUser();
    if (currentUser == null) return null;
    final User? user = await getUser(currentUser.uid);
    return user;
  }

  // userIDでuserを取得したらstreamで監視
  Stream<User> getUserStream(String userId) {
    return _db.collection('users').doc(userId).snapshots().map(
        (snapshot) => User.fromJson(snapshot.data()!..addAll({"id": userId})));
  }

  Future<void> createUser(User user) async {
    await _db.collection('users').doc(user.id).set(user.toJson());
  }

  Future<void> updateUser(String userId, User user) async {
    await _db.collection('users').doc(userId).update(user.toJson());
  }

  Future<bool> isUniqueBleUserId(String bleUserId) async {
    final querySnapshot = await _db
        .collection('users')
        .where('bleUserId', isEqualTo: bleUserId)
        .get();
    return querySnapshot.docs.isEmpty;
  }
}
