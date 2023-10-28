import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_state.freezed.dart';

@freezed
class ConnectState with _$ConnectState {
  factory ConnectState({
    @Default(false) bool connected,
  }) = _ConnectState;
}
