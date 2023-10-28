// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id =>
      throw _privateConstructorUsedError; // Firebase Authenticationのuid
  String get name => throw _privateConstructorUsedError; // 名前
  String get profileImageUrl => throw _privateConstructorUsedError; // 画像のurl
  String get location => throw _privateConstructorUsedError; // 出身地
  String get techArea => throw _privateConstructorUsedError; // 好き・得意な技術領域
  String get xId => throw _privateConstructorUsedError; // SNS Xのid
  String get instagramId =>
      throw _privateConstructorUsedError; // SNSのInstagramのid
  String get homepageLink => throw _privateConstructorUsedError; // ホームページのリンク
  String get deviceUuid =>
      throw _privateConstructorUsedError; // BluetoothデバイスのUUID
  String get bleUserId =>
      throw _privateConstructorUsedError; // Bluetoothデバイスに渡すユーザーID
  String get lastCheersUserId =>
      throw _privateConstructorUsedError; // 最後に乾杯したuserのid
  List<String> get cheerUserIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String name,
      String profileImageUrl,
      String location,
      String techArea,
      String xId,
      String instagramId,
      String homepageLink,
      String deviceUuid,
      String bleUserId,
      String lastCheersUserId,
      List<String> cheerUserIds});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? profileImageUrl = null,
    Object? location = null,
    Object? techArea = null,
    Object? xId = null,
    Object? instagramId = null,
    Object? homepageLink = null,
    Object? deviceUuid = null,
    Object? bleUserId = null,
    Object? lastCheersUserId = null,
    Object? cheerUserIds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      techArea: null == techArea
          ? _value.techArea
          : techArea // ignore: cast_nullable_to_non_nullable
              as String,
      xId: null == xId
          ? _value.xId
          : xId // ignore: cast_nullable_to_non_nullable
              as String,
      instagramId: null == instagramId
          ? _value.instagramId
          : instagramId // ignore: cast_nullable_to_non_nullable
              as String,
      homepageLink: null == homepageLink
          ? _value.homepageLink
          : homepageLink // ignore: cast_nullable_to_non_nullable
              as String,
      deviceUuid: null == deviceUuid
          ? _value.deviceUuid
          : deviceUuid // ignore: cast_nullable_to_non_nullable
              as String,
      bleUserId: null == bleUserId
          ? _value.bleUserId
          : bleUserId // ignore: cast_nullable_to_non_nullable
              as String,
      lastCheersUserId: null == lastCheersUserId
          ? _value.lastCheersUserId
          : lastCheersUserId // ignore: cast_nullable_to_non_nullable
              as String,
      cheerUserIds: null == cheerUserIds
          ? _value.cheerUserIds
          : cheerUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String profileImageUrl,
      String location,
      String techArea,
      String xId,
      String instagramId,
      String homepageLink,
      String deviceUuid,
      String bleUserId,
      String lastCheersUserId,
      List<String> cheerUserIds});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? profileImageUrl = null,
    Object? location = null,
    Object? techArea = null,
    Object? xId = null,
    Object? instagramId = null,
    Object? homepageLink = null,
    Object? deviceUuid = null,
    Object? bleUserId = null,
    Object? lastCheersUserId = null,
    Object? cheerUserIds = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      techArea: null == techArea
          ? _value.techArea
          : techArea // ignore: cast_nullable_to_non_nullable
              as String,
      xId: null == xId
          ? _value.xId
          : xId // ignore: cast_nullable_to_non_nullable
              as String,
      instagramId: null == instagramId
          ? _value.instagramId
          : instagramId // ignore: cast_nullable_to_non_nullable
              as String,
      homepageLink: null == homepageLink
          ? _value.homepageLink
          : homepageLink // ignore: cast_nullable_to_non_nullable
              as String,
      deviceUuid: null == deviceUuid
          ? _value.deviceUuid
          : deviceUuid // ignore: cast_nullable_to_non_nullable
              as String,
      bleUserId: null == bleUserId
          ? _value.bleUserId
          : bleUserId // ignore: cast_nullable_to_non_nullable
              as String,
      lastCheersUserId: null == lastCheersUserId
          ? _value.lastCheersUserId
          : lastCheersUserId // ignore: cast_nullable_to_non_nullable
              as String,
      cheerUserIds: null == cheerUserIds
          ? _value._cheerUserIds
          : cheerUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  _$UserImpl(
      {required this.id,
      required this.name,
      required this.profileImageUrl,
      required this.location,
      required this.techArea,
      required this.xId,
      required this.instagramId,
      required this.homepageLink,
      required this.deviceUuid,
      required this.bleUserId,
      required this.lastCheersUserId,
      required final List<String> cheerUserIds})
      : _cheerUserIds = cheerUserIds;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
// Firebase Authenticationのuid
  @override
  final String name;
// 名前
  @override
  final String profileImageUrl;
// 画像のurl
  @override
  final String location;
// 出身地
  @override
  final String techArea;
// 好き・得意な技術領域
  @override
  final String xId;
// SNS Xのid
  @override
  final String instagramId;
// SNSのInstagramのid
  @override
  final String homepageLink;
// ホームページのリンク
  @override
  final String deviceUuid;
// BluetoothデバイスのUUID
  @override
  final String bleUserId;
// Bluetoothデバイスに渡すユーザーID
  @override
  final String lastCheersUserId;
// 最後に乾杯したuserのid
  final List<String> _cheerUserIds;
// 最後に乾杯したuserのid
  @override
  List<String> get cheerUserIds {
    if (_cheerUserIds is EqualUnmodifiableListView) return _cheerUserIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cheerUserIds);
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, profileImageUrl: $profileImageUrl, location: $location, techArea: $techArea, xId: $xId, instagramId: $instagramId, homepageLink: $homepageLink, deviceUuid: $deviceUuid, bleUserId: $bleUserId, lastCheersUserId: $lastCheersUserId, cheerUserIds: $cheerUserIds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.techArea, techArea) ||
                other.techArea == techArea) &&
            (identical(other.xId, xId) || other.xId == xId) &&
            (identical(other.instagramId, instagramId) ||
                other.instagramId == instagramId) &&
            (identical(other.homepageLink, homepageLink) ||
                other.homepageLink == homepageLink) &&
            (identical(other.deviceUuid, deviceUuid) ||
                other.deviceUuid == deviceUuid) &&
            (identical(other.bleUserId, bleUserId) ||
                other.bleUserId == bleUserId) &&
            (identical(other.lastCheersUserId, lastCheersUserId) ||
                other.lastCheersUserId == lastCheersUserId) &&
            const DeepCollectionEquality()
                .equals(other._cheerUserIds, _cheerUserIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      profileImageUrl,
      location,
      techArea,
      xId,
      instagramId,
      homepageLink,
      deviceUuid,
      bleUserId,
      lastCheersUserId,
      const DeepCollectionEquality().hash(_cheerUserIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  factory _User(
      {required final String id,
      required final String name,
      required final String profileImageUrl,
      required final String location,
      required final String techArea,
      required final String xId,
      required final String instagramId,
      required final String homepageLink,
      required final String deviceUuid,
      required final String bleUserId,
      required final String lastCheersUserId,
      required final List<String> cheerUserIds}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override // Firebase Authenticationのuid
  String get name;
  @override // 名前
  String get profileImageUrl;
  @override // 画像のurl
  String get location;
  @override // 出身地
  String get techArea;
  @override // 好き・得意な技術領域
  String get xId;
  @override // SNS Xのid
  String get instagramId;
  @override // SNSのInstagramのid
  String get homepageLink;
  @override // ホームページのリンク
  String get deviceUuid;
  @override // BluetoothデバイスのUUID
  String get bleUserId;
  @override // Bluetoothデバイスに渡すユーザーID
  String get lastCheersUserId;
  @override // 最後に乾杯したuserのid
  List<String> get cheerUserIds;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
