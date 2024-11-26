import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/core.dart';

class CustomRowTransaksi extends StatelessWidget {
  final String title;
  final String dataTransaksi;
  const CustomRowTransaksi({
    super.key,
    required this.title,
    required this.dataTransaksi,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: darkTitleText.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          dataTransaksi.capitalize!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
