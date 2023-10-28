// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ConnectState {
  bool get isConnecting => throw _privateConstructorUsedError;
  BluetoothDevice? get connectedDevice => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConnectStateCopyWith<ConnectState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectStateCopyWith<$Res> {
  factory $ConnectStateCopyWith(
          ConnectState value, $Res Function(ConnectState) then) =
      _$ConnectStateCopyWithImpl<$Res, ConnectState>;
  @useResult
  $Res call({bool isConnecting, BluetoothDevice? connectedDevice});
}

/// @nodoc
class _$ConnectStateCopyWithImpl<$Res, $Val extends ConnectState>
    implements $ConnectStateCopyWith<$Res> {
  _$ConnectStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnecting = null,
    Object? connectedDevice = freezed,
  }) {
    return _then(_value.copyWith(
      isConnecting: null == isConnecting
          ? _value.isConnecting
          : isConnecting // ignore: cast_nullable_to_non_nullable
              as bool,
      connectedDevice: freezed == connectedDevice
          ? _value.connectedDevice
          : connectedDevice // ignore: cast_nullable_to_non_nullable
              as BluetoothDevice?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConnectStateImplCopyWith<$Res>
    implements $ConnectStateCopyWith<$Res> {
  factory _$$ConnectStateImplCopyWith(
          _$ConnectStateImpl value, $Res Function(_$ConnectStateImpl) then) =
      __$$ConnectStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isConnecting, BluetoothDevice? connectedDevice});
}

/// @nodoc
class __$$ConnectStateImplCopyWithImpl<$Res>
    extends _$ConnectStateCopyWithImpl<$Res, _$ConnectStateImpl>
    implements _$$ConnectStateImplCopyWith<$Res> {
  __$$ConnectStateImplCopyWithImpl(
      _$ConnectStateImpl _value, $Res Function(_$ConnectStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnecting = null,
    Object? connectedDevice = freezed,
  }) {
    return _then(_$ConnectStateImpl(
      isConnecting: null == isConnecting
          ? _value.isConnecting
          : isConnecting // ignore: cast_nullable_to_non_nullable
              as bool,
      connectedDevice: freezed == connectedDevice
          ? _value.connectedDevice
          : connectedDevice // ignore: cast_nullable_to_non_nullable
              as BluetoothDevice?,
    ));
  }
}

/// @nodoc

class _$ConnectStateImpl implements _ConnectState {
  _$ConnectStateImpl({this.isConnecting = false, this.connectedDevice = null});

  @override
  @JsonKey()
  final bool isConnecting;
  @override
  @JsonKey()
  final BluetoothDevice? connectedDevice;

  @override
  String toString() {
    return 'ConnectState(isConnecting: $isConnecting, connectedDevice: $connectedDevice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectStateImpl &&
            (identical(other.isConnecting, isConnecting) ||
                other.isConnecting == isConnecting) &&
            (identical(other.connectedDevice, connectedDevice) ||
                other.connectedDevice == connectedDevice));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isConnecting, connectedDevice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectStateImplCopyWith<_$ConnectStateImpl> get copyWith =>
      __$$ConnectStateImplCopyWithImpl<_$ConnectStateImpl>(this, _$identity);
}

abstract class _ConnectState implements ConnectState {
  factory _ConnectState(
      {final bool isConnecting,
      final BluetoothDevice? connectedDevice}) = _$ConnectStateImpl;

  @override
  bool get isConnecting;
  @override
  BluetoothDevice? get connectedDevice;
  @override
  @JsonKey(ignore: true)
  _$$ConnectStateImplCopyWith<_$ConnectStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
