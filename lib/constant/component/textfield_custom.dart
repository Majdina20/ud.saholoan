import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:udsaholoan/constant/component/theme.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    super.key,
    this.obsecureText = false,
    required this.hintText,
    this.icon,
    required this.textEditingController,
    required this.keyboardType,
    this.inputFormatters,
    required this.textInputAction,
    this.filled = false,
    this.colorFilled,
  });

  final TextEditingController textEditingController;
  final bool obsecureText;
  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final IconData? icon;
  final bool? filled;
  final Color? colorFilled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obsecureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        filled: filled,
        fillColor: colorFilled,
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
