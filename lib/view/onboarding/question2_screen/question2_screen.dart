import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Question2Screen extends ConsumerWidget {
  const Question2Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appbar = AppBar(
      title: const Text("ログイン"),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );

    return Scaffold(
        appBar: appbar,
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        body: Padding(
          padding: EdgeInsets.only(
              top: 32 + appbar.preferredSize.height,
              left: 32,
              right: 32,
              bottom: 32),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "好き／得意な領域は？",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        "地元トークで盛り上がれるかも！？",
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ),
                SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                        onPressed: () async {
                          // MaterialPageRoute(builder: () => )
                        },
                        child: const Text(
                          "次へ",
                        ))),
              ]),
        ));
  }
}
