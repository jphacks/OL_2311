import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/models/cheer_model.dart';

final cheerRepositoryProvider = Provider<CheerRepository>((ref) {
  final db = FirebaseFirestore.instance;
  return CheerRepository(db);
});

class CheerRepository {
  final FirebaseFirestore _db;

  CheerRepository(this._db);

  Stream<List<Cheer>> getCheersStream() {
    return _db.collection('cheers').snapshots().map((snapshot) => snapshot.docs
        .where((doc) => doc.exists)
        .where((doc) => doc.data().isNotEmpty)
        .map((doc) => Cheer.fromJson(doc.data()))
        .toList()); // snapshot.docsをCheerに変換
  }

  Future<Cheer?> getCheer(String cheerId) async {
    final res = await _db.collection('cheers').doc(cheerId).get();
    if (res.data() == null) return null;
    return Cheer.fromJson(res.data()!);
  }

  // fromUserIdとtoUserIdが一致する最新のcheerIdを取得
  Future<String?> getCheerIdByFromUserIdAndToUserId(
      String fromUserId, String toUserId) async {
    final querySnapshot = await _db
        .collection('cheers')
        .where('fromUserId', isEqualTo: fromUserId)
        .where('toUserId', isEqualTo: toUserId)
        .orderBy('timestampS', descending: true)
        .limit(1)
        .get();
    return querySnapshot.docs.first.id;
  }

  Stream<Cheer> getCheerStream(String cheerId) {
    return _db
        .collection('cheers')
        .doc(cheerId)
        .snapshots()
        .map((snapshot) => Cheer.fromJson(snapshot.data()!));
  }

  Future<void> createCheer(Cheer cheer) async {
    await _db.collection('cheers').add({
      ...cheer.toJson(),
      'createdAt': FieldValue.serverTimestamp(), // サーバータイムスタンプを追加
    });
  }

  Future<void> updateCheer(String cheerId, Cheer cheer) async {
    await _db.collection('cheers').doc(cheerId).update(cheer.toJson());
  }
}
