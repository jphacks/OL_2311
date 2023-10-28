import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_state.freezed.dart';

@freezed
class ConnectState with _$ConnectState {
  factory ConnectState({
    @Default(false) bool isConnecting,
    @Default(null) BluetoothDevice? connectedDevice,
    @Default(false) bool hasError,
  }) = _ConnectState;
}
