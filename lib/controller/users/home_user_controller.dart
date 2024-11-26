import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeUserController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool isLoading = false.obs;

  RxString searchQuery = ''.obs;
  RxString filter = 'All'.obs;

  RxString size = ''.obs;
  RxString colors = ''.obs;

  RxInt counter = 1.obs;
  void increment() => counter + 1;
  void decrement() {
    counter - 1;
    if (counter <= 1) {
      counter = 1.obs;
    }
  }

  RxBool isOrder = false.obs;
  RxString pembayaranVia = ''.obs;

  Stream<QuerySnapshot<Object?>>? allProduct(final listProdukC) {
    return FirebaseFirestore.instance
        .collection('products')
        .where('product_name',
            isGreaterThanOrEqualTo: listProdukC.toLowerCase())
        .where('product_name',
            isLessThanOrEqualTo: '${listProdukC.toLowerCase()}\uf8ff')
        .orderBy('product_name')
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>>? productFilter(String filter) {
    return FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: filter)
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>>? filterTabBar() {
    return FirebaseFirestore.instance
        .collection('products')
        .orderBy('category')
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>>? produkRatingTertinggi() {
    return FirebaseFirestore.instance
        .collection('products')
        .orderBy('rating', descending: true)
        .limit(2)
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>>? produkTerbaru() {
    return FirebaseFirestore.instance
        .collection('products')
        .orderBy('timestamp', descending: true)
        .limit(2)
        .snapshots();
  }

  Future<Map<String, dynamic>?> getNomorDana({required String idAdmin}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('admin')
          .doc(idAdmin)
          .get();

      if (snapshot.exists) {
        return snapshot.data();
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting nomorDana: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getNomorUser() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (snapshot.exists) {
        return snapshot.data();
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting nomorDana: $e');
      return null;
    }
  }

  void goToCart({
    required String photo,
    required String namaProduk,
    required String namaToko,
    required String deskripsiProduk,
    required int price,
    required String noHpPembeli,
  }) async {
    try {
      if (colors.value == '' || size.value == '' || pembayaranVia.value == '') {
        Get.defaultDialog(
          title: 'Pembayaran Gagal',
          middleText: 'Data Tidak Lengkap',
          onConfirm: () {
            isOrder.value = false;
            Get.back();
          },
          textConfirm: 'Oke',
        );
      } else {
        isLoading.value = true;
        // masukkan data controller ke firedatabase
        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection('transaksi').doc().set({
          'photo': photo,
          'id': FirebaseAuth.instance.currentUser!.uid,
          'namaProduk': namaProduk,
          'namaToko': namaToko,
          'deskripsiProduk': deskripsiProduk,
          'whatAColor': colors.value,
          'whatASize': size.value,
          'quantity': counter.value,
          'price': price,
          'nohp_pembeli': noHpPembeli,
          'pembayaranVia': pembayaranVia.value,
          'statusBelanja': 'Dalam Proses',
          'timestamp': DateTime.now(),
        });
        Future.delayed(const Duration(seconds: 2), () {
          isLoading.value = false;
        });
        Get.back();
        Get.back();
      }
    } catch (e) {
      Get.defaultDialog(
          title: 'Ada Kesalahan', middleText: 'Coba ulangi beberapa saat');
    }
  }
}
