import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/pages/user/main_user.dart';

class RegisterUserController extends GetxController {
  RxBool isLoading = false.obs;
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController usernameC = TextEditingController();
  final TextEditingController phoneC = TextEditingController();

  void signUpWithUser(
    String email,
    String password,
    String username,
    String phone,
  ) async {
    try {
      isLoading.value = true;
      FirebaseAuth auth = FirebaseAuth.instance;

      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // cek create user yang barusan dibuat
      String userId = userCredential.user!.uid;

      // masukkan data controller ke firedatabase
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection('users').doc(userId).set({
        'email': email,
        'nama_pengguna': username,
        'no_telp': phone,
        'profile_picture': '',
        'role': 'USER',
      });

      emailC.clear();
      passwordC.clear();
      usernameC.clear();
      phoneC.clear();

      isLoading.value = false;
      Get.off(() => MainUser());
    } on FirebaseAuthException {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: 'Email dan password sudah pernah digunakan');
    } catch (e) {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: 'Email dan password sudah pernah digunakan');
    }
  }
}
