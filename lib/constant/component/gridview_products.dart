import 'package:flutter/material.dart';

class GridViewProducts extends StatelessWidget {
  const GridViewProducts({
    super.key,
    required this.onTap,
    required this.photo,
    // required this.productName,
    // required this.price,
  });

  final VoidCallback onTap;
  final String? photo;
  // final String productName;
  // final String price;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: photo != null
                ? Image.network(
                    photo!,
                    width: 165,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/contoh.png",
                    width: 165,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(
            height: 5,
          ),
          // SizedBox(
          //   width: 151,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         productName.capitalize!,
          //         style: darkTitleText,
          //         maxLines: 2,
          //         overflow: TextOverflow.ellipsis,
          //         textAlign: TextAlign.center,
          //       ),
          //       const SizedBox(
          //         height: 5.0,
          //       ),
          //       Text(
          //         formatCurrency.format(int.parse(price)),
          //         maxLines: 1,
          //         overflow: TextOverflow.ellipsis,
          //         style: darkTitleText.copyWith(fontWeight: FontWeight.bold),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
