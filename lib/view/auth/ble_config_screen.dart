import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/main.dart';

class BleConfigScreen extends HookConsumerWidget {
  const BleConfigScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(sharedPreferencesProvider);
    final deviceUuid = prefs.getString("deviceUuid");

    final textController = useTextEditingController(text: deviceUuid ?? "");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          const Text('ハードウェアのUUIDを設定'),
          const SizedBox(height: 20),
          TextField(
            controller: textController,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () async {
                await prefs.setString("deviceUuid", textController.value.text);
                Navigator.of(context).pop();
              },
              child: const Text(
                "確定",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
