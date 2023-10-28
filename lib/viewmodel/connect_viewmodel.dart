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

  Future<void> connect() async {
    state = state.copyWith(isConnecting: true);
    try {
      final device = await _bleConnector.connect();
      state = state.copyWith(connectedDevice: device);
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(isConnecting: false);
    }
  }
}
