import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/components/form_item.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

Future<String?> showQrCaptureSheet(BuildContext context) {
  return showModalBottomSheet<String?>(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return const _QrCaptureSheet();
    },
  );
}

class _QrCaptureSheet extends HookConsumerWidget {
  const _QrCaptureSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showTextbox = useState(false);
    final codeController = useTextEditingController();
    final isClosing = useRef(false);

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: const BorderRadius.all(
            Radius.circular(32),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: showTextbox.value ? keyboardHeight + 16 : 16),
        height: showTextbox.value ? 320 : 500,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: showTextbox.value
              ? [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "カップホルダーの登録",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          FormItem(
                            label: "カップホルダーのID",
                            controller: codeController,
                            autofocus: true,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context, codeController.value.text);
                            },
                            child: const Text("確定"),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextButton.icon(
                              icon: const Icon(
                                Icons.chevron_left,
                                color: Colors.black87,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              label: const Text(
                                "QRコードを読み込む",
                                style: TextStyle(color: Colors.black87),
                              ))
                        ],
                      ),
                    ),
                  ),
                ]
              : [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          height: 240,
                          width: 240,
                          child: MobileScanner(
                            fit: BoxFit.cover,
                            overlay: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 180,
                              height: 180,
                            ),
                            onDetect: (capture) {
                              final value = capture.barcodes.firstOrNull;
                              if (value != null && !isClosing.value) {
                                isClosing.value = true;
                                Navigator.pop(context, value.rawValue);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 16, bottom: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "カップホルダーのQRコードをスキャンしてください",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                showTextbox.value = true;
                              },
                              child: const Text("コードを直接入力する")),
                        ],
                      ),
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}
