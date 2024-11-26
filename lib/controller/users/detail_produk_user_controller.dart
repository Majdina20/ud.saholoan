import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DetailProdukUserController extends GetxController {
  RxBool isLoading = false.obs;

  RxBool colorSelected = false.obs;
  RxInt whatAColor = 0.obs;

  RxBool sizeSelected = false.obs;
  RxString whatASize = ''.obs;

  RxString nomorRekening = ''.obs;
  RxString nomorDana = ''.obs;
  RxString nomorWa = ''.obs;
  RxInt isButton = 0.obs;

  var counter = 1.obs;

  void increment() => counter + 1;
  void reset() => counter.value = 0;

  void decrement() {
    counter - 1;
    if (counter <= 1) {
      counter = 1.obs;
    }
  }

  void goToCart({
    required String photo,
    required String namaProduk,
    required String namaToko,
    required String deskripsiProduk,
    required int whatAColor,
    required String whatASize,
    required int quantity,
    required int price,
    required num rating,
    required String idPenjual,
    required String idProduk,
  }) async {
    try {
      isLoading.value = true;
      // masukkan data controller ke firedatabase
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection('transaksi').doc().set({
        'photo': photo,
        'id': FirebaseAuth.instance.currentUser!.uid,
        'namaProduk': namaProduk,
        'namaToko': namaToko,
        'deskripsiProduk': deskripsiProduk,
        'whatAColor': whatAColor,
        'whatASize': whatASize,
        'quantity': quantity,
        'price': price,
        'rating': rating,
        'hasbeenRating': false,
        'id_penjual': idPenjual,
        'id_produk': idProduk,
        'statusBelanja': 'Belum Dibayar',
        'timestamp': DateTime.now(),
      });
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
        Get.back();
        Get.back();
      });
    } catch (e) {
      Get.defaultDialog(
          title: 'Ada Kesalahan', middleText: 'Coba ulangi beberapa saat');
    }
  }

  @override
  void onClose() {
    isButton.close();
    counter.value = 1;
    super.onClose();
  }
  // void goToCart(
  //   String photo,
  //   String namaProduk,
  //   String deskripsiProduk,
  //   int whatAColor,
  //   String whatASize,
  //   int quantity,
  //   int price,
  // ) async {
  //   try {
  //     if (whatAColor != 0 && whatASize != '') {
  //       // masukkan data controller ke firedatabase
  //       FirebaseFirestore db = FirebaseFirestore.instance;
  //       await db.collection('keranjang').doc().set({
  //         'photo': photo,
  //         'id': FirebaseAuth.instance.currentUser!.uid,
  //         'namaProduk': namaProduk,
  //         'deskripsiProduk': deskripsiProduk,
  //         'whatAColor': whatAColor,
  //         'whatASize': whatASize,
  //         'quantity': quantity,
  //         'price': price,
  //         'statusBelanja': 'Belum Dibayar'
  //       });
  //     } else {
  //       Get.defaultDialog(
  //           title: 'Ada Kesalahan', middleText: 'Warna dan Size belum dipilih');
  //     }
  //   } catch (e) {
  //     Get.defaultDialog(
  //         title: 'Ada Kesalahan', middleText: 'Coba ulangi beberapa saat');
  //   }
  // }
}
