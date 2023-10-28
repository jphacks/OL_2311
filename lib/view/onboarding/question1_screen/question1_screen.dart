import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/view/onboarding/question2_screen/question2_screen.dart';

class Question1Screen extends HookConsumerWidget {
  const Question1Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appbar = AppBar(
      title: const Text("ログイン"),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );

    final selectedArea = useState(null);

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
                        "出身地はどこですか？",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "地元トークで盛り上がれるかも！？",
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      "北海道・東北",
                      "関東",
                      "中部",
                      "近畿",
                      "中国・四国",
                      "九州・沖縄",
                      "海外"
                    ]
                        .map((label) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: FilledButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    alignment: Alignment.centerLeft,
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    foregroundColor: MaterialStateProperty.all(
                                        Colors.black87),
                                    textStyle: MaterialStateProperty.all(
                                        const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            height: 1.5,
                                            color: Colors.black87)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(16))),
                                child: Text(label),
                              ),
                            ))
                        .toList()),
                SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const Question2Screen()));
                        },
                        child: const Text(
                          "次へ",
                        ))),
              ]),
        ));
  }
}
