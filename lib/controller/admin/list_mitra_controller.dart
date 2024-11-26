import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListMitraController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>>? streamAll() {
    return FirebaseFirestore.instance
        .collection('mitra')
        .orderBy('email')
        .snapshots();
  }

  Future<String> updatePersetujuan({
    required String doc,
  }) async {
    String resp = 'Some error Occurred';
    try {
      await db.collection('mitra').doc(doc).update({
        'izin_akses': true,
        'waktu_disetujui': DateTime.now(),
      });

      Get.back();
      return resp = 'success';
    } catch (e) {
      Get.defaultDialog(title: 'Izin Gagal Diberikan');
    }
    return resp;
  }
}
