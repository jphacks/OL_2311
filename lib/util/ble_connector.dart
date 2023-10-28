import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/util/bluetooth_ext.dart';

final bleConnectorProvider = Provider((ref) => BleConnector());

class BleConnector {
  static const targetUuid = "B616EAC0-9CB1-4453-F93F-6DFBAB1F18B4";

  Future<BluetoothDevice> connect() async {
    BluetoothDevice? targetDevice;

    final scanResultsSubscription = FlutterBluePlus.scanResults.listen(
      (results) {
        targetDevice = results
            .where((elt) => elt.device.remoteId.str == targetUuid)
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
      print('Target device is already connected');
    } else {
      targetDevice!.connectAndUpdateStream().catchError((e) {
        throw Exception("Cannot connect target device");
      });
    }

    return targetDevice!;
  }
}
