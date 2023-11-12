import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanpai/components/profile_card/profile_card.dart';
import 'package:kanpai/components/tab_button.dart';
import 'package:kanpai/components/user_icon_panel.dart';
import 'package:kanpai/main.dart';
import 'package:kanpai/models/user_model.dart';
import 'package:kanpai/util/bluetooth_ext.dart';
import 'package:kanpai/view_models/auth_view_model.dart';
import 'package:kanpai/view_models/kanpai_view_model.dart';

enum KanpaiTab {
  all,
  done,
  notDone;
}

class KanpaiScreen extends HookConsumerWidget {
  KanpaiScreen({
    super.key,
    required this.targetDevice,
  });

  final BluetoothDevice? targetDevice;
  late StreamSubscription<List<int>> _kanpaiSubscription;

  void startKanpaiListener(
    void Function(String fromId, String toId) handler,
    String currentUserId,
  ) async {
    print('start listener');
    await targetDevice!.connectAndUpdateStream();
    final characteristic = await targetDevice!.getNotifyCharacteristic();
    print('characteristic: $characteristic');
    if (characteristic == null) return;

    _kanpaiSubscription = characteristic.lastValueStream.listen((value) {
      print('arrive value: $value');
      if (value.isEmpty) return;

      final toUserId = utf8.decode(value);
      final fromUserId = currentUserId;

      debugPrint('cheers occurred from $fromUserId to $toUserId');
      handler(fromUserId, toUserId);
    });

    await characteristic.setNotifyValue(true);
    print('isNotifying: ${characteristic.isNotifying}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);
    final meId = authState.appUser?.id;

    final selectedTab = useState<KanpaiTab>(KanpaiTab.all);
    final ascending = useState<bool>(true);
    final prefs = ref.watch(sharedPreferencesProvider);
    final currentUserId = prefs.getString("currentUserId");

    final homeViewModel = ref.watch(homeViewModelProvider.notifier);
    final users = ref
        .watch(homeViewModelProvider)
        .maybeWhen(data: (data) => data, orElse: () => <User>[]);

    final me = users.where((u) => u.id == meId).firstOrNull;

    useEffect(() {
      homeViewModel.fetchUsers();
      return () {};
    }, []);

    final kanpaiCount = useMemoized(() {
      try {
        return me?.cheerUserIds?.length ?? 0;
      } on StateError catch (_) {
        return 0;
      }
    }, [users, meId]);

    final alreadyCheersUserCount = useMemoized(
        () =>
            users.where((u) => u.cheerUserIds?.contains(meId) ?? false).length,
        [users, meId]);

    final allUserCount = useMemoized(() => users.length - 1, [users]);

    final latestCheeredUser = useMemoized(() {
      try {
        final latestCheeredUserId =
            me?.cheerUserIds?.lastWhere((id) => id != meId);
        return users.firstWhere((u) => u.id == latestCheeredUserId);
      } on StateError catch (_) {
        return null;
      }
    }, [users, meId]);

    final filteredUsers = useMemoized(() {
      final filteredUsers = switch (selectedTab.value) {
        KanpaiTab.all => users,
        KanpaiTab.done =>
          users.where((u) => (u.cheerUserIds?.contains(meId) ?? false)),
        KanpaiTab.notDone =>
          users.where((u) => (!(u.cheerUserIds?.contains(meId) ?? false))),
      };
      if (ascending.value) {
        return filteredUsers.toList();
      } else {
        return filteredUsers.toList().reversed;
      }
    }, [users, selectedTab.value, ascending.value]);

    final viewmodel = ref.watch(homeViewModelProvider.notifier);

    useEffect(() {
      if (targetDevice == null) {
        return () {};
      }
      startKanpaiListener(viewmodel.cheers, currentUserId!);
      return () => _kanpaiSubscription.cancel();
    }, []);

    final appbar = AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () async {
          await targetDevice?.disconnect();
          if (!context.mounted) {
            return;
          }
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(kanpaiCount == 0
                        ? "assets/images/kanpai-bg-black.png"
                        : "assets/images/kanpai-bg-blue.png"),
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
                        ProfileCard(user: latestCheeredUser),
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
                        if (me != null)
                          _buildUserGrid(context, me: me, users: filteredUsers),
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

  Widget _buildUserGrid(BuildContext context,
      {required User me, required Iterable<User> users}) {
    if (users.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: SizedBox(
          width: 40,
          child: Image.asset(
            "assets/images/kanpai-1.png",
            width: 100,
            height: 100,
          ),
        ),
      );
    }

    final deviceWidth = MediaQuery.of(context).size.width;

    return Wrap(
        spacing: 16,
        runSpacing: 24,
        children: users.map((user) {
          final cheersCount =
              me.cheerUserIds?.where((id) => id == user.id).length ?? 0;
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
