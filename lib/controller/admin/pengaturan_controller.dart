import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PengaturanController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final TextEditingController nameC = TextEditingController();
  RxString updateNamaAdmin = ''.obs;

  Stream<QuerySnapshot<Object?>>? streamAll() {
    return FirebaseFirestore.instance.collection('admin').snapshots();
  }

  Future<String> updateNamaProfilAdmin({
    required String doc,
    required String nama,
  }) async {
    String resp = 'Some error Occurred';
    try {
      await db.collection('admin').doc(doc).update({
        "nama_admin": nama,
      });

      updateNamaAdmin.value = nama;
      Get.back();
      return resp = 'success';
    } catch (e) {
      Get.defaultDialog(
          title: 'Gagal Update Nama. Silahkan coba beberapa saat');
    }
    return resp;
  }
}
