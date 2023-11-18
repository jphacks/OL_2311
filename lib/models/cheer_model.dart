import 'package:freezed_annotation/freezed_annotation.dart';

part 'cheer_model.freezed.dart';
part 'cheer_model.g.dart';

@freezed
class Cheer with _$Cheer {
  factory Cheer({
    required String fromUserId,
    required String toUserId,
    List<String>? keywords,
    required int timestamp,
  }) = _Cheer;

  factory Cheer.fromJson(Map<String, dynamic> json) => _$CheerFromJson(json);
}
