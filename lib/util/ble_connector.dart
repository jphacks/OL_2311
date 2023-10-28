import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:kanpai/util/bluetooth_ext.dart';

class BleConnector {
  BleConnector({
    required this.targetUuid,
  });

  final String targetUuid;

  Future<void> connect() async {
    FlutterBluePlus.scanResults.listen((results) {
      final targetDevice = results
          .where(
            (elt) => elt.device.remoteId.str == targetUuid,
          )
          .firstOrNull
          ?.device;

      if (targetDevice == null) {
        throw Exception("Cannot find target device");
      }

      targetDevice.connectAndUpdateStream().catchError((e) {
        throw Exception("Cannot connect target device");
      });
    });

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
  }
}
