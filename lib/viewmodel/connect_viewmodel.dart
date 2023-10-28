import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/util/ble_connector.dart';
import 'package:kanpai/viewmodel/connect_state.dart';

final connectViewModelProvider =
    StateNotifierProvider<ConnectViewModel, ConnectState>(
  (ref) {
    final bleConnector = ref.watch(bleConnectorProvider);
    return ConnectViewModel(bleConnector: bleConnector);
  },
);

class ConnectViewModel extends StateNotifier<ConnectState> {
  ConnectViewModel({
    required BleConnector bleConnector,
  })  : _bleConnector = bleConnector,
        super(ConnectState());

  final BleConnector _bleConnector;

  Future<BluetoothDevice?> connect() async {
    state = state.copyWith(isConnecting: true);

    try {
      debugPrint('Connected device found, disconnecting...');
      await state.connectedDevice?.disconnect();

      final device = await _bleConnector.connect();
      state = state.copyWith(connectedDevice: device);
      debugPrint('Connected device: $device');
      return device;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    } finally {
      state = state.copyWith(isConnecting: false);
    }
  }
}
