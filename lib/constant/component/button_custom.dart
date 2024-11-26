import 'package:flutter/material.dart';
import 'package:udsaholoan/constant/component/theme.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({super.key, required this.ontap, required this.title});

  final VoidCallback ontap;
  final String title;

  @override
  Widget build(BuildContext context) {
    final fullWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: fullWidth,
        height: 55,
        decoration: BoxDecoration(
          color: basicColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: buttonText,
          ),
        ),
      ),
    );
  }
}
