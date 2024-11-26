import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:udsaholoan/pages/admin/home_admin.dart';
import 'package:udsaholoan/pages/user/main_user.dart';

class LoginController extends GetxController {
  final isAuth = false.obs;
  RxBool isLoading = false.obs;
  final rememberme = false.obs;
  late TextEditingController emailC = TextEditingController();
  late TextEditingController passwordC = TextEditingController();

  Future<void> autoLogin() async {
    final box = GetStorage();
    if (box.read('DataLogin') != null) {
      final data = box.read('DataLogin') as Map<String, dynamic>;
      signInwithEmail(
        data['email'],
        data['password'],
        data['rememberme'],
      );
    }
  }

  void logOut() {
    final box = GetStorage();
    if (box.read('DataLogin') != null) {
      box.erase();
    }
    isAuth.value = false;
    Get.delete<LoginController>();
  }

  void signInwithEmail(
    String email,
    String password,
    bool rememberme,
  ) async {
    try {
      isLoading.value = true;
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final userUid = credential.user!.uid;
      final adminDoc = await FirebaseFirestore.instance
          .collection('admin')
          .doc(userUid)
          .get();

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .get();

      if (userDoc.exists || adminDoc.exists) {
        String? role;

        if (userDoc.exists) {
          role = userDoc.data()?['role'];
        } else if (adminDoc.exists) {
          role = adminDoc.data()?['role'];
        }

        if (role != null) {
          if (rememberme) {
            final box = GetStorage();
            box.write('DataLogin', {
              'email': email,
              'password': password,
              'rememberme': rememberme,
            });
          } else {
            final box = GetStorage();
            if (box.read('DataLogin') != null) {
              box.erase();
            }
          }
          isAuth.value = true;
          isLoading.value = false;
          navigateToHomePageBasedOnRole(role);
        } else {
          // Handle case where role is not specified
        }
      }
    } on FirebaseAuthException catch (_) {
      isLoading.value = false;
      Get.defaultDialog(
          title: 'Terjadi Kesalahan', middleText: 'Email dan password salah');
    }
  }

  void navigateToHomePageBasedOnRole(String role) {
    switch (role) {
      case 'USER':
        // Redirect to homeUser
        Get.off(() => MainUser());
        break;
      case 'ADMIN':
        // Redirect to homeAdmin
        Get.off(() => HomeAdmin());
        break;
      default:
      // Handle unknown role as needed
    }
  }

  @override
  void onInit() async {
    emailC = TextEditingController();
    passwordC = TextEditingController();
    await GetStorage.init();
    final box = GetStorage();
    if (box.read('DataLogin') != null) {
      final data = box.read('DataLogin') as Map<String, dynamic>;
      emailC.text = data['email'];
      passwordC.text = data['password'];
      rememberme.value = data['rememberme'];
    } else {}
    super.onInit();
  }
}
