import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RiwayatBelanjaUserController extends GetxController {
  Stream<QuerySnapshot<Object?>>? riwayatBelanja() {
    return FirebaseFirestore.instance
        .collection('transaksi')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  void updateRating({
    required String id,
    required String idProduk,
    required num updateRating,
  }) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      Map<String, dynamic> updateDataRating = {
        'rating': updateRating,
        'hasbeenRating': true,
      };
      await db.collection('transaksi').doc(id).update(updateDataRating);
      await db.collection('products').doc(idProduk).update(updateDataRating);
      Get.back();
    } catch (e) {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: 'Silahkan coba beberapa saat lagi');
    }
  }
}
