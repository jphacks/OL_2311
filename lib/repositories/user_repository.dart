import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/models/user_model.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final db = FirebaseFirestore.instance;
  return UserRepository(db);
});

class UserRepository {
  final FirebaseFirestore _db;

  UserRepository(this._db);

  // userを全件取得
  Stream<List<User>> getUsersStream() {
    return _db.collection('users').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => User.fromJson(doc.data()))
        .toList()); // snapshot.docsをUserに変換
  }

  // userIdでuserを取得
  Future<User> getUser(String userId) async {
    final snapshot = await _db.collection('users').doc(userId).get();
    return User.fromJson(snapshot.data()!);
  }

  // userIDでuserを取得したらstreamで監視
  Stream<User> getUserStream(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => User.fromJson(snapshot.data()!));
  }

  Future<void> createUser(User user) async {
    await _db.collection('users').doc(user.id).set(user.toJson());
  }

  Future<void> updateUser(String userId, User user) async {
    await _db.collection('users').doc(user.id).update(user.toJson());
  }
}
