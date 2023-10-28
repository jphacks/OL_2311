import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kanpai/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _db;

  UserRepository(this._db);

  Stream<List<User>> getUsers() {
    return _db.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
    });
  }
}
