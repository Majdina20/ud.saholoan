// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:udsaholoan/core.dart';

class TextformDescription extends StatelessWidget {
  const TextformDescription({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.icon,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String hintText;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 5,
      maxLines: null,
      controller: textEditingController,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: greyColor,
          ), // Warna tepi saat aktif
        ),
      ),
    );
  }
}
