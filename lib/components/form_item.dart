import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormItem extends HookConsumerWidget {
  const FormItem(
      {super.key,
      required this.label,
      required this.controller,
      this.description,
      this.hintText,
      this.helperText,
      this.autofocus = false,
      this.maxLines = 1});

  final String label;
  final String? description;
  final String? hintText;
  final String? helperText;
  final TextEditingController controller;
  final bool autofocus;
  final int maxLines;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        if (description != null) ...[
          Text(description ?? "", style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          autofocus: autofocus,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            helperText: helperText,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                color: Color(0xffBDBDBD),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                color: Color(0xffBDBDBD),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
