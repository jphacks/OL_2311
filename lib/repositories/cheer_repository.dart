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
        .map((doc) => Cheer.fromJson(doc.data()))
        .toList()); // snapshot.docsをCheerに変換
  }

  Future<Cheer?> getCheer(String cheerId) async {
    final res = await _db.collection('cheers').doc(cheerId).get();
    if (res.data() == null) return null;
    return Cheer.fromJson(res.data()!);
  }

  Stream<Cheer> getCheerStream(String cheerId) {
    return _db
        .collection('cheers')
        .doc(cheerId)
        .snapshots()
        .map((snapshot) => Cheer.fromJson(snapshot.data()!));
  }

  Future<void> createCheer(Cheer cheer) async {
    await _db.collection('cheers').add(cheer.toJson());
  }
}
