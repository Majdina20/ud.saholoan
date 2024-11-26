import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/controller/auth/login_controller.dart';
import 'package:udsaholoan/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:udsaholoan/pages/auth/login.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final loginC = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loginC.autoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return GetMaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                scrolledUnderElevation: 0,
              ),
            ),
            home: LoginPage(),
          );
        }
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
            ),
          ),
          home: LoginPage(),
        );
      },
    );
  }
}
