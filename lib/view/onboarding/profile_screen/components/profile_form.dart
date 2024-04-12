import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanpai/components/form_item.dart';

class ProfileForm extends HookWidget {
  const ProfileForm({
    super.key,
    required this.usernameController,
    required this.bioController,
  });

  final TextEditingController usernameController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormItem(
          label: "ユーザーネーム",
          description: "乾杯する相手に表示される名前です。",
          controller: usernameController,
        ),
        const SizedBox(height: 24),
        FormItem(
          label: "ひとこと",
          hintText: "（例）はじめまして、よろしくお願いします！",
          controller: bioController,
          maxLines: 2,
        ),
      ],
    );
  }
}
