import 'package:flutter/material.dart';
import 'package:udsaholoan/core.dart';

class CustomButton extends StatelessWidget {
  final dynamic onTap;
  final String title;
  final Color? color;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: color ?? abuButton,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}
