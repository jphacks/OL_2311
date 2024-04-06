import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  factory User({
    required String id, // Firebase Authenticationのuid
    String? username, // 名前
    String? email, // メールアドレス
    String? bio, // ひとこと
    String? profileImageUrl, // 画像のurl
    String? location, // 出身地
    String? techArea, // 好き・得意な技術領域
    String? xId, // SNS Xのid
    String? instagramId, // SNSのInstagramのid
    String? githubId, // SNSのGitHubのid
    String? websiteLink, // ウェブサイトのリンク
    String? deviceUuid, // BluetoothデバイスのUUID
    String? bleUserId, // Bluetoothデバイスに渡すユーザーID
    String? lastCheersUserId, // 最後に乾杯したuserのid
    List<String>? cheerUserIds, // 過去に乾杯したことのあるuserのids
    List<String>? keywords, // 乾杯のトピック
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
