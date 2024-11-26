import 'package:flutter/material.dart';
import 'package:udsaholoan/core.dart';

class CustomButtonPersetujuan extends StatelessWidget {
  final dynamic onTap;
  final String title;
  const CustomButtonPersetujuan(
      {super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: basicColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(
                title,
                style: darkTitleText.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
