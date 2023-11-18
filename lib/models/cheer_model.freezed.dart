// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cheer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Cheer _$CheerFromJson(Map<String, dynamic> json) {
  return _Cheer.fromJson(json);
}

/// @nodoc
mixin _$Cheer {
  String get fromUserId => throw _privateConstructorUsedError;
  String get toUserId => throw _privateConstructorUsedError;
  List<String>? get keywords => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheerCopyWith<Cheer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheerCopyWith<$Res> {
  factory $CheerCopyWith(Cheer value, $Res Function(Cheer) then) =
      _$CheerCopyWithImpl<$Res, Cheer>;
  @useResult
  $Res call(
      {String fromUserId,
      String toUserId,
      List<String>? keywords,
      int timestamp});
}

/// @nodoc
class _$CheerCopyWithImpl<$Res, $Val extends Cheer>
    implements $CheerCopyWith<$Res> {
  _$CheerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? keywords = freezed,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      fromUserId: null == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String,
      toUserId: null == toUserId
          ? _value.toUserId
          : toUserId // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: freezed == keywords
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheerImplCopyWith<$Res> implements $CheerCopyWith<$Res> {
  factory _$$CheerImplCopyWith(
          _$CheerImpl value, $Res Function(_$CheerImpl) then) =
      __$$CheerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fromUserId,
      String toUserId,
      List<String>? keywords,
      int timestamp});
}

/// @nodoc
class __$$CheerImplCopyWithImpl<$Res>
    extends _$CheerCopyWithImpl<$Res, _$CheerImpl>
    implements _$$CheerImplCopyWith<$Res> {
  __$$CheerImplCopyWithImpl(
      _$CheerImpl _value, $Res Function(_$CheerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? keywords = freezed,
    Object? timestamp = null,
  }) {
    return _then(_$CheerImpl(
      fromUserId: null == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String,
      toUserId: null == toUserId
          ? _value.toUserId
          : toUserId // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: freezed == keywords
          ? _value._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheerImpl implements _Cheer {
  _$CheerImpl(
      {required this.fromUserId,
      required this.toUserId,
      final List<String>? keywords,
      required this.timestamp})
      : _keywords = keywords;

  factory _$CheerImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheerImplFromJson(json);

  @override
  final String fromUserId;
  @override
  final String toUserId;
  final List<String>? _keywords;
  @override
  List<String>? get keywords {
    final value = _keywords;
    if (value == null) return null;
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int timestamp;

  @override
  String toString() {
    return 'Cheer(fromUserId: $fromUserId, toUserId: $toUserId, keywords: $keywords, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheerImpl &&
            (identical(other.fromUserId, fromUserId) ||
                other.fromUserId == fromUserId) &&
            (identical(other.toUserId, toUserId) ||
                other.toUserId == toUserId) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fromUserId, toUserId,
      const DeepCollectionEquality().hash(_keywords), timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheerImplCopyWith<_$CheerImpl> get copyWith =>
      __$$CheerImplCopyWithImpl<_$CheerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheerImplToJson(
      this,
    );
  }
}

abstract class _Cheer implements Cheer {
  factory _Cheer(
      {required final String fromUserId,
      required final String toUserId,
      final List<String>? keywords,
      required final int timestamp}) = _$CheerImpl;

  factory _Cheer.fromJson(Map<String, dynamic> json) = _$CheerImpl.fromJson;

  @override
  String get fromUserId;
  @override
  String get toUserId;
  @override
  List<String>? get keywords;
  @override
  int get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$CheerImplCopyWith<_$CheerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
