import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatar extends HookWidget {
  const ProfileAvatar({
    super.key,
    required this.initialProfileImage,
    required this.profileImage,
    required this.onPickImage,
  });

  final String? initialProfileImage;
  final File? profileImage;
  final Future<void> Function(ImageSource) onPickImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(clipBehavior: Clip.none, children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: profileImage != null
                ? FileImage(profileImage!)
                : initialProfileImage != null
                    ? NetworkImage(File(initialProfileImage!).path)
                        as ImageProvider
                    : null,
          ),
          Positioned(
              bottom: -6,
              right: -6,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xffE0E0E0),
                    width: 1,
                  ),
                ),
                child: GestureDetector(
                  onTap: () => onPickImage(ImageSource.gallery),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.photo_library,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                  ),
                ),
              ))
        ]));
  }
}
