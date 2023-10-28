import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:kanpai/util/stream_ext.dart';

final Map<DeviceIdentifier, StreamControllerReemit<bool>> _global = {};

extension Extra on BluetoothDevice {
  // convenience
  StreamControllerReemit<bool> get _stream {
    _global[remoteId] ??= StreamControllerReemit(initialValue: false);
    return _global[remoteId]!;
  }

  Stream<bool> get isConnectingOrDisconnecting {
    return _stream.stream;
  }

  Future<void> connectAndUpdateStream() async {
    _stream.add(true);
    try {
      await connect();
    } finally {
      _stream.add(false);
    }
  }

  Future<void> disconnectAndUpdateStream() async {
    _stream.add(true);
    try {
      await disconnect();
    } finally {
      _stream.add(false);
    }
  }
}
