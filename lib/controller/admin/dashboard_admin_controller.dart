import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardAdminController extends GetxController {
  Stream<QuerySnapshot<Object?>>? streamProdukLength() {
    return FirebaseFirestore.instance.collection('products').snapshots();
  }

  Stream<QuerySnapshot<Object?>>? streamMitraLength() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }

  Stream<QuerySnapshot<Object?>>? streamTransaksi(String status) {
    return FirebaseFirestore.instance
        .collection('transaksi')
        .where('statusBelanja', isEqualTo: status)
        .snapshots();
  }

  Future<Map<String, dynamic>?> getNamaPembeli({required String idUser}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(idUser)
          .get();

      if (snapshot.exists) {
        return snapshot.data();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  updateStatusBelanja(
      {required String statusBelanja, required String doc}) async {
    try {
      Map<String, dynamic> editProductData = {
        'statusBelanja': statusBelanja,
      };
      await FirebaseFirestore.instance
          .collection('transaksi')
          .doc(doc)
          .update(editProductData);
      Get.back();
    } catch (e) {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: 'Silahkan coba kembali nanti');
    }
  }
}
