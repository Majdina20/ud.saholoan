import 'package:flutter/material.dart';
import 'package:udsaholoan/constant/component/theme.dart';

class DrawerItemUtils extends StatelessWidget {
  const DrawerItemUtils(
      {super.key,
      required this.ontap,
      required this.icon,
      required this.title});

  final VoidCallback ontap;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            icon,
            width: 24,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 25.0,
          ),
          Flexible(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: darkTitleText.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItemLockUtils extends StatelessWidget {
  const DrawerItemLockUtils(
      {super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 28.0,
          color: Colors.black,
        ),
        const SizedBox(
          width: 25.0,
        ),
        Flexible(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: darkTitleText.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Icon(
          Icons.lock_outline,
          size: 14,
          color: Colors.grey,
        ),
      ],
    );
  }
}
