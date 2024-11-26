import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class WidgetUserController extends GetxController {
  RxString searchQuery = ''.obs;
  RxString filter = 'All'.obs;

  // Stream<QuerySnapshot<Object?>>? filterTabBar() {
  //   return FirebaseFirestore.instance
  //       .collection('products')
  //       .orderBy('category')
  //       .snapshots();
  // }

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

  Stream<QuerySnapshot<Object?>>? produkRekomendasi() {
    return FirebaseFirestore.instance
        .collection('products')
        .where('rekomendasi', isEqualTo: true)
        .snapshots();
  }
}
