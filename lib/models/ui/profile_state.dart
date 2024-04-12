import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kanpai/models/user_model.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    required String? username,
    required String? bio,
    required String? profileImageUrl,
    required bool isLoading,
  }) = _ProfileState;

  factory ProfileState.initial(User? user) {
    return ProfileState(
      username: user?.username,
      bio: user?.bio,
      profileImageUrl: user?.profileImageUrl,
      isLoading: false,
    );
  }
}
