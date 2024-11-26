import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RegisterMitraController extends GetxController {
  RxBool isLoading = false.obs;

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController namaTokoC = TextEditingController();
  final TextEditingController phoneC = TextEditingController();

  void signUpWithMitra(
    String email,
    String password,
    String namaToko,
    String phone,
  ) async {
    try {
      isLoading.value = true;
      FirebaseAuth auth = FirebaseAuth.instance;

      final mitraCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // cek create user yang barusan dibuat
      String mitraId = mitraCredential.user!.uid;

      // masukkan data controller ke firedatabase
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection('mitra').doc(mitraId).set({
        'email': email,
        'nama_toko': namaToko,
        'no_telp': phone,
        'dana': '',
        'nomor_rekening': '',
        'foto_toko': '',
        'izin_akses': false,
        'role': 'MITRA',
        'profile_picture': '',
        'nama_rekening': '',
        'kode_bank': '',
        'timestamp': DateTime.now(),
      });

      emailC.clear();
      passwordC.clear();
      namaTokoC.clear();
      phoneC.clear();
      isLoading.value = false;
      // Get.off(() => HomeMitra());
    } on FirebaseAuthException {
      isLoading.value = false;
      Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: 'Email dan password sudah pernah digunakan');
    } catch (e) {
      isLoading.value = false;
      Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: 'Email dan password sudah pernah digunakan');
    }
  }
}
