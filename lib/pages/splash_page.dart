import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/pages/auth/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    var duration = const Duration(seconds: 1);
    Timer(
      duration,
      (() => Get.off(() => LoginPage())),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/splash_image.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
