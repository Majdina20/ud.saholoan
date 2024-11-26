import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ProfileUserController extends GetxController {
  final isAuth = false.obs;
  final storage = FirebaseStorage.instance;
  RxBool isLoading = false.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxString updateNamaAdmin = ''.obs;

  final TextEditingController nameC = TextEditingController();
  final TextEditingController noTelpC = TextEditingController();

  void logOut() {
    final box = GetStorage();
    if (box.read('DataLogin') != null) {
      box.erase();
    }
    isAuth.value = false;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>? profileUser() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
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

      await db
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        "nama_pengguna": nameC.text,
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
      Get.defaultDialog(
          title: 'Gagal Update Profile. Silahkan coba beberapa saat');
    }
    return resp;
  }
}
