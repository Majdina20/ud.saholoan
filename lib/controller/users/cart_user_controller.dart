import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class CartUserController extends GetxController {
  RxBool isAlreadyDelete = false.obs;
  final storage = FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxInt subTotal = 0.obs;

  updateSubTotal(int value) {
    subTotal.value = value;
  }

  addSubtotal({required int value}) {
    try {
      db
          .collection("pembayaran")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'subtotal': value,
      });
    } on FirebaseException {
      Get.defaultDialog(
          middleText: 'Terjadi Kesalahan Periksa Koneksi Internet Anda');
    } finally {
      isAlreadyDelete.value = false;
    }
  }

  removeItemAndUpdateTotal(int itemPrice) {
    subTotal.value -= itemPrice;
  }

  removeSubtotal({required int value}) {
    try {
      if (subTotal.value != 0) {
        db
            .collection("pembayaran")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'subtotal': value,
        });
      } else {
        db
            .collection("pembayaran")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'subtotal': 0,
        });
      }
    } on FirebaseException {
      Get.defaultDialog(
          middleText: 'Terjadi Kesalahan Periksa Koneksi Internet Anda');
    } finally {
      isAlreadyDelete.value = false;
    }
  }

  Stream<QuerySnapshot<Object?>>? quantityOfTheCart() {
    return FirebaseFirestore.instance.collection('keranjang').snapshots();
  }

  Stream<DocumentSnapshot<Object?>>? pembayaranSubtotal() {
    return FirebaseFirestore.instance
        .collection('pembayaran')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  void deleteFromKeranjang({
    required String doc,
  }) async {
    isAlreadyDelete.value = true;

    try {
      Get.back();
      db.collection("keranjang").doc(doc).delete();
    } on FirebaseException {
      Get.defaultDialog(
          middleText: 'Terjadi Kesalahan Periksa Koneksi Internet Anda');
    } finally {
      isAlreadyDelete.value = false;
    }
  }
}
