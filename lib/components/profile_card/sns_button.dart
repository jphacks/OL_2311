import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/link.dart';

class SnsButton extends HookConsumerWidget {
  const SnsButton({super.key, required this.url, required this.icon});

  final String url;
  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Link(
        uri: Uri.parse(url),
        builder: (BuildContext context, FollowLink? followLink) => InkWell(
              onTap: followLink,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8)),
                child: FaIcon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ));
  }
}
