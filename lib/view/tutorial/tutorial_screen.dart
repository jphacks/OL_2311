import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/view/tutorial/tutorial_layout.dart';

class Tutorial1Screen extends HookConsumerWidget {
  const Tutorial1Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMemoized(() => CarouselController());
    final page = useState(0);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final isFinalPage = page.value == 3;

    return TutorialLayout(
      indicator: page.value,
      nextLabel: isFinalPage ? "スタート" : "次へ",
      onNextPressed: () {
        if (isFinalPage) {
          Navigator.of(context).pop();
        } else {
          controller.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        }
      },
      onSkip: isFinalPage
          ? null
          : () {
              Navigator.of(context).pop();
            },
      child: CarouselSlider(
        carouselController: controller,
        options: CarouselOptions(
          onPageChanged: (index, _) => page.value = index,
          initialPage: 0,
          height: height * 0.8,
          enableInfiniteScroll: false,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
        ),
        items: [
          // Page 1
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/tutorial1.png",
                width: 200,
              ),
              const SizedBox(height: 32),
              const Text(
                "“乾杯” をきっかけに\n仲良くなれる\nカップホルダー型デバイスです",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    height: 2.4,
                    letterSpacing: 1.3),
              ),
            ],
          ),
          // Page 2
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/tutorial2.png",
                width: width,
              ),
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "“乾杯” で\nSNSが\n自動的に交換",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      height: 2.4,
                      letterSpacing: 1.3),
                ),
              ),
            ],
          ),
          // Page 3
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/tutorial3.png",
                width: width,
              ),
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "“乾杯” で\n他の参加者のプロフィール\nがアンロック",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      height: 2.4,
                      letterSpacing: 1.3),
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/tutorial4.png",
                width: width,
              ),
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "さあ、\nコンプリート目指して\nみんなと乾杯しよう！",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      height: 2.4,
                      letterSpacing: 1.3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
