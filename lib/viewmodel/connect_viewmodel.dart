import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/viewmodel/connect_state.dart';

class ConnectViewModel extends StateNotifier<ConnectState> {
  ConnectViewModel() : super(ConnectState());

  Future<void> connect() async {}
}
