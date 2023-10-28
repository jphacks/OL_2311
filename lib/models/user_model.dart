import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class User with _$User {
  factory User({
    required String id, // Firebase Authenticationのuid
    required String name, // 名前
    required String profileImageUrl, // 画像のurl
    required String location, // 出身地
    required String techArea, // 好き・得意な技術領域
    required String xId, // SNS Xのid
    required String instagramId, // SNSのInstagramのid
    required String homepageLink, // ホームページのリンク
    required String deviceUuid, // BluetoothデバイスのUUID
    required String bleUserId, // Bluetoothデバイスに渡すユーザーID
    required String lastCheersUserId, // 最後に乾杯したuserのid
    required List<String> cheerUserIds, // 過去に乾杯したことのあるuserのids
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
