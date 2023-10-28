import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/util/bluetooth_ext.dart';

final bleConnectorProvider = Provider(
  (ref) => BleConnector(),
);

class BleConnector {
  Future<BluetoothDevice> connect(
      String deviceUuid, String currentUserId) async {
    BluetoothDevice? targetDevice;

    final scanResultsSubscription = FlutterBluePlus.scanResults.listen(
      (results) {
        targetDevice = results
            .where((elt) => elt.device.remoteId.str == deviceUuid)
            .firstOrNull
            ?.device;
      },
    );

    // --- Scan Start ---
    const scanDuration = Duration(seconds: 3);
    await FlutterBluePlus.startScan(
      timeout: scanDuration,
    );
    await Future.delayed(scanDuration);
    scanResultsSubscription.cancel();
    // --- Scan finish ---

    if (targetDevice == null) {
      throw Exception("Cannot find target device");
    }

    if (targetDevice!.isConnected) {
      debugPrint('Target device is already connected');
    } else {
      await targetDevice!.connectAndUpdateStream().catchError((e) {
        throw Exception("Cannot connect target device");
      });
    }

    final writeCharacteristic = await targetDevice!.getWriteCharacteristic();
    await writeCharacteristic!.write(utf8.encode(currentUserId));

    return targetDevice!;
  }
}
