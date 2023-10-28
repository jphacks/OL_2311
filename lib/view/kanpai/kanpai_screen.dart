import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/components/profile_card/profile_card.dart';
import 'package:kanpai/components/tab_button.dart';
import 'package:kanpai/components/user_icon_panel.dart';
import 'package:kanpai/models/user_model.dart';

enum KanpaiTab {
  all,
  done,
  notDone;
}

// Userコレクションから取得されるデータを想定
final _mockUsers = List.generate(10, (i) => i).map((i) => User(
        id: i == 0 ? "me" : "id-$i",
        name: "まろすけ $i",
        profileImageUrl:
            "https://img.freepik.com/free-photo/closeup-of-a-cute-cat-sitting-on-the-carpet-against-a-blurred-background_181624-53498.jpg",
        location: "近畿",
        techArea: "フロントエンド",
        xId: "twitter",
        instagramId: "instagram",
        homepageLink: "https://example.com",
        deviceUuid: "1a0e8d92-756b-11ee-b962-0242ac120002",
        bleUserId: "ABCDEF",
        lastCheersUserId: "d309306d-2095-4562-ba38-bc54d88f8a64",
        cheerUserIds: [
          "d309306d-2095-4562-ba38-bc54d88f8a64",
          if (i % 2 == 1) "me",
          "d309306d-2095-4562-ba38-bc54d88f8a64",
          if (i % 2 == 1) "me"
        ]));

// ログインしているユーザーのデータを想定
final _me = _mockUsers.first;

class KanpaiScreen extends HookConsumerWidget {
  const KanpaiScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState<KanpaiTab>(KanpaiTab.all);
    final ascending = useState<bool>(true);

    final kanpaiCount = useMemoized(
        () =>
            _mockUsers.firstWhere((u) => u.id == _me.id).cheerUserIds?.length ??
            0,
        [_mockUsers]);

    final alreadyCheersUserCount = useMemoized(
        () => _mockUsers
            .where((u) => u.cheerUserIds?.contains(_me.id) ?? false)
            .length,
        [_mockUsers]);

    final allUserCount = useMemoized(() => _mockUsers.length, [_mockUsers]);

    final users = useMemoized(() {
      final users = switch (selectedTab.value) {
        KanpaiTab.all => _mockUsers.where((u) => u.id != _me.id),
        KanpaiTab.done => _mockUsers.where((u) =>
            u.id != _me.id && (u.cheerUserIds?.contains(_me.id) ?? false)),
        KanpaiTab.notDone => _mockUsers.where((u) =>
            u.id != _me.id && (!(u.cheerUserIds?.contains(_me.id) ?? false))),
      };
      if (ascending.value) {
        return users.toList();
      } else {
        return users.toList().reversed;
      }
    }, [_mockUsers, selectedTab.value, ascending.value]);

    final appbar = AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.account_circle_outlined,
            color: Colors.white,
          ),
        )
      ],
    );

    return Scaffold(
        appBar: appbar,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/kanpai-bg-blue.png"),
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter)),
            child: Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 160),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 320,
                    child: _buildCounter(kanpaiCount),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const ProfileCard(),
                        const SizedBox(
                          height: 52,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("乾杯した人数",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            Text("$alreadyCheersUserCount / $allUserCount",
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontFamily: "Chillax",
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildTabbar(context,
                            selectedTab: selectedTab, ascending: ascending),
                        const SizedBox(
                          height: 24,
                        ),
                        _buildUserGrid(context, me: _me, users: users),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Column _buildCounter(int kanpaiCount) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("乾杯した総回数",
            style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                height: 1,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        Text("$kanpaiCount",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 54,
                fontFamily: "Chillax",
                height: 1,
                fontWeight: FontWeight.w600)),
        SvgPicture.asset(
          "assets/svgs/kanpai-logo.svg",
          height: 28,
          theme: const SvgTheme(currentColor: Colors.white),
        ),
      ],
    );
  }

  Row _buildTabbar(BuildContext context,
      {required ValueNotifier<KanpaiTab> selectedTab,
      required ValueNotifier<bool> ascending}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            TabButton(
                isSelected: selectedTab.value == KanpaiTab.all,
                onSelected: () => selectedTab.value = KanpaiTab.all,
                child: _buildTabButtonText(context,
                    label: "すべて",
                    isSelected: selectedTab.value == KanpaiTab.all)),
            const SizedBox(
              width: 4,
            ),
            TabButton(
                isSelected: selectedTab.value == KanpaiTab.notDone,
                onSelected: () => selectedTab.value = KanpaiTab.notDone,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTabButtonText(context,
                        label: "未 ",
                        isSelected: selectedTab.value == KanpaiTab.notDone),
                    _buildTabButtonIcon(selectedTab.value == KanpaiTab.notDone),
                  ],
                )),
            const SizedBox(
              width: 4,
            ),
            TabButton(
                isSelected: selectedTab.value == KanpaiTab.done,
                onSelected: () => selectedTab.value = KanpaiTab.done,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTabButtonIcon(selectedTab.value == KanpaiTab.done),
                    _buildTabButtonText(context,
                        label: " 済",
                        isSelected: selectedTab.value == KanpaiTab.done),
                  ],
                )),
          ],
        ),
        OutlinedButton.icon(
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.black87)),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 8)),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              foregroundColor: MaterialStateProperty.all(Colors.black87),
              overlayColor: MaterialStateProperty.all(Colors.black12),
            ),
            icon: Icon(
              ascending.value ? Icons.arrow_downward : Icons.arrow_upward,
              size: 16,
            ),
            onPressed: () {
              ascending.value = !ascending.value;
            },
            label: const Text("名前"))
      ],
    );
  }

  Wrap _buildUserGrid(BuildContext context,
      {required User me, required Iterable<User> users}) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Wrap(
        spacing: 16,
        runSpacing: 24,
        children: users.map((user) {
          final cheersCount =
              user.cheerUserIds?.where((id) => id == me.id).length ?? 0;
          return SizedBox(
              width: (deviceWidth - 60) / 2,
              child: UserIconPanel(
                user: user,
                count: cheersCount,
              ));
        }).toList());
  }

  SvgPicture _buildTabButtonIcon(bool isSelected) {
    return SvgPicture.asset(
      "assets/svgs/kanpai-logo.svg",
      height: 22,
      theme:
          SvgTheme(currentColor: isSelected ? Colors.black87 : Colors.black54),
    );
  }

  Text _buildTabButtonText(BuildContext context,
      {required String label, required bool isSelected}) {
    return Text(label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: isSelected ? Colors.black87 : Colors.black54,
            fontWeight: FontWeight.bold));
  }
}
