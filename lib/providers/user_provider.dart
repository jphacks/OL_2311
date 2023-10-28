import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/repositories/user_repository.dart';
import 'package:kanpai/view_models/home_view_model.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final db = FirebaseFirestore.instance;
  return UserRepository(db);
});

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, AsyncValue<List<User>>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return HomeViewModel(userRepository);
});
