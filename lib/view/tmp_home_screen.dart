import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/util/bluetooth_ext.dart';
import 'package:kanpai/view_models/home_view_model.dart';

class TmpHomeScreen extends ConsumerStatefulWidget {
  const TmpHomeScreen({
    super.key,
    required this.targetDevice,
  });

  final BluetoothDevice targetDevice;

  @override
  ConsumerState<TmpHomeScreen> createState() => _TmpHomeScreenState();
}

class _TmpHomeScreenState extends ConsumerState<TmpHomeScreen> {
  late StreamSubscription<List<int>> _kanpaiListener;

  void startKanpaiListener() async {
    await widget.targetDevice.connectAndUpdateStream();
    final services = await widget.targetDevice.discoverServices();
    if (services.isEmpty) return;

    final service = services.first;
    final characteristic = service.characteristics
        .where((c) => c.properties.notify || c.properties.indicate)
        .firstOrNull;
    if (characteristic == null) return;

    _kanpaiListener = characteristic.lastValueStream.listen((value) {
      final decodedValue = utf8.decode(value);
    });
    characteristic.setNotifyValue(true);
  }

  @override
  void initState() {
    super.initState();
    startKanpaiListener();
  }

  @override
  void dispose() {
    _kanpaiListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ホーム画面')),
      body: const Column(
        children: [],
      ),
    );
  }
}
