import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/models/connect_state.dart';
import 'package:kanpai/util/ble_connector.dart';
import 'package:kanpai/util/bluetooth_ext.dart';
import 'package:kanpai/view/onboarding/question2_screen/tech_area.dart';

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

  Future<BluetoothDevice?> connect(
    String deviceUuid,
    String bleUserId,
    TechArea? techArea,
  ) async {
    state = state.copyWith(isConnecting: true, hasError: false);

    try {
      debugPrint('Connected device found, disconnecting...');
      await state.connectedDevice?.disconnect();

      final device = await _bleConnector.connect(deviceUuid, bleUserId);
      final writeCharacteristic = await device.getWriteCharacteristic();
      final colorString = techArea?.color.toCustomString();
      if (colorString != null) {
        await writeCharacteristic?.write(utf8.encode(colorString));
      }

      state = state.copyWith(connectedDevice: device);
      debugPrint('Connected device: $device');
      return device;
    } catch (e) {
      debugPrint(e.toString());
      state = state.copyWith(hasError: true);
      return null;
    } finally {
      state = state.copyWith(isConnecting: false);
    }
  }
}
