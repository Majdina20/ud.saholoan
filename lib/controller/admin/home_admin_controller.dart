import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class HomeAdminC extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxInt currentDrawer = 0.obs;
  RxString urlPembayaran = ''.obs;
  RxString updateNamaAdmin = ''.obs;
  RxBool isLoading = false.obs;

  RxString updateNoTelpAdminC = ''.obs;
  final storage = FirebaseStorage.instance;

  final TextEditingController nameC = TextEditingController();
  final TextEditingController noTelpC = TextEditingController();

  Stream<DocumentSnapshot<Map<String, dynamic>>>? streamAll() {
    return FirebaseFirestore.instance
        .collection('admin')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>>? streamPengaturan() {
    return FirebaseFirestore.instance.collection('admin').snapshots();
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      return await xFile.readAsBytes();
    }
  }

  Future<String> uploadImage(Uint8List file, String childName) async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = '$childName-$timestamp';
    final storageRef = storage.ref();
    final uploadTask = storageRef.child('$fileName-${const Uuid().v4()}.jpg');
    await uploadTask.putData(file);
    return await uploadTask.getDownloadURL();
  }

  Future<String> saveProfile({
    required String doc,
    required Uint8List? fileGambar,
    String? existingImageUrl,
  }) async {
    String resp = 'Some error Occurred';
    try {
      isLoading.value = true;
      String imgUrl = existingImageUrl ?? '';
      if (fileGambar != null) {
        imgUrl = await uploadImage(fileGambar, 'fotoProduk');
      }

      await db.collection('admin').doc(doc).update({
        "nama_admin": nameC.text,
        "no_telp": noTelpC.text,
        'profile_picture': imgUrl,
        'timestamp': DateTime.now(),
      });

      updateNamaAdmin.value = nameC.text;
      nameC.clear();
      noTelpC.clear();

      isLoading.value = false;
      Get.back();
      return resp = 'success';
    } catch (e) {
      isLoading.value = false;
      Get.defaultDialog(
          title: 'Gagal Update Profile. Silahkan coba beberapa saat');
    }
    isLoading.value = false;
    return resp;
  }

  Future<String> updateProfilAdmin({
    required String doc,
  }) async {
    String resp = 'Some error Occurred';
    try {
      await db.collection('admin').doc(doc).update({
        "nama_admin": nameC.text,
        "no_telp": noTelpC.text,
      });

      updateNamaAdmin.value = nameC.text;
      nameC.clear();
      noTelpC.clear();

      return resp = 'success';
    } catch (e) {
      Get.defaultDialog(
          title: 'Gagal Update Profile. Silahkan coba beberapa saat');
    }
    return resp;
  }

  Future<String> updateNamaProfilAdmin({
    required String doc,
  }) async {
    String resp = 'Some error Occurred';
    try {
      await db.collection('admin').doc(doc).update({
        "nama_admin": nameC.text,
      });

      updateNamaAdmin.value = nameC.text;
      nameC.clear();
      Get.back();

      return resp = 'success';
    } catch (e) {
      Get.defaultDialog(
          title: 'Gagal Update Nama. Silahkan coba beberapa saat');
    }
    return resp;
  }

  Future<String> updateNoTelpAdmin({
    required String doc,
  }) async {
    String resp = 'Some error Occurred';
    try {
      await db.collection('admin').doc(doc).update({
        "no_telp": noTelpC.text,
      });

      noTelpC.clear();
      Get.back();

      return resp = 'success';
    } catch (e) {
      Get.defaultDialog(
          title: 'Gagal Update Nama. Silahkan coba beberapa saat');
    }
    return resp;
  }
}
