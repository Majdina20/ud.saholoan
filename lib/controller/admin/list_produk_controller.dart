import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ListProdukController extends GetxController {
  RxString searchQuery = ''.obs;
  RxString filter = 'All'.obs;

  RxBool isAlreadyDelete = false.obs;
  RxBool isRekomendasi = false.obs;
  Rx<Uint8List?> image = Rx<Uint8List?>(null);

  late TextEditingController productC = TextEditingController();
  late TextEditingController descriptionC = TextEditingController();
  late TextEditingController priceC = TextEditingController();
  late TextEditingController categoryC = TextEditingController();
  late TextEditingController photoC = TextEditingController();
  late TextEditingController ratingC = TextEditingController();
  late TextEditingController colorC = TextEditingController();
  late TextEditingController sizeC = TextEditingController();
  List<String> colors = [];
  List<String> size = [];
  // List<Color> currentColors = [];

  final storage = FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

// updateSearchQuery tidak dipakai
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

  Future<String> saveData({
    required String nameProduct,
    required String descProduct,
    required String priceProduct,
    required String categoryProduct,
    required bool rekomendasi,
    required num ratingProduct,
    required String urlPembayaran,
    required String uploadBy,
    required Uint8List fileGambar,
    List<String>? size,
    List<Color>? colors,
  }) async {
    String resp = 'Some error Occurred';
    try {
      if (nameProduct.isNotEmpty ||
          priceProduct.isNotEmpty ||
          categoryProduct.isNotEmpty) {
        String imgUrl = await uploadImage(fileGambar, 'fotoProduk');

        Map<String, dynamic> productData = {
          "photo": imgUrl,
          "product_name": nameProduct,
          "price": priceProduct,
          "category": categoryProduct,
          'rekomendasi': rekomendasi,
          "description": descProduct,
          "rating": ratingProduct,
          'urlPembayaran': urlPembayaran,
          'upload_by': uploadBy,
          'timestamp': DateTime.now(),
        };

        if (size != null) {
          productData['size'] = size;
        }

        if (colors != null) {
          List<int> colorIntegers = colors.map((color) => color.value).toList();

          // Konversi nilai integer ke format heksadesimal
          List<String> hexColorStrings = colorIntegers.map((colorValue) {
            return '0x${colorValue.toRadixString(16).padLeft(8, '0')}'; // Pad with 8 digits
          }).toList();
          productData['colors'] = hexColorStrings;
        }
        await db.collection('products').doc().set(productData);

        productC.clear();
        descriptionC.clear();
        priceC.clear();
        categoryC.clear();
        ratingC.clear();
        size!.clear();

        Get.back();
        return resp = 'success';
      }
    } catch (e) {
      Get.defaultDialog(title: 'Produk Gagal Ditambahkan');
    }
    return resp;
  }

  Future<String> editData({
    required String nameProduct,
    required String descProduct,
    required String priceProduct,
    required String categoryProduct,
    required bool rekomendasi,
    List<String>? size,
    List<Color>? colors,
    required num ratingProduct,
    required Uint8List? fileGambar,
    required String doc,
    String? existingImageUrl,
    required String urlPembayaran,
  }) async {
    String resp = 'Some error Occurred';
    try {
      if (nameProduct.isNotEmpty ||
          priceProduct.isNotEmpty ||
          categoryProduct.isNotEmpty) {
        String imgUrl = existingImageUrl ?? '';
        if (fileGambar != null) {
          imgUrl = await uploadImage(fileGambar, 'fotoProduk');
        }

        Map<String, dynamic> editProductData = {
          "photo": imgUrl,
          "product_name": nameProduct,
          "price": priceProduct,
          "category": categoryProduct,
          "description": descProduct,
          "rating": ratingProduct,
          'urlPembayaran': urlPembayaran,
          'rekomendasi': rekomendasi,
          'timestamp': DateTime.now(),
        };

        if (size != null) {
          editProductData['size'] = size;
        }
        if (colors != null) {
          List<int> colorIntegers = colors.map((color) => color.value).toList();
          List<String> hexColorStrings = colorIntegers.map((colorValue) {
            return '0x${colorValue.toRadixString(16).padLeft(8, '0')}';
          }).toList();

          editProductData['colors'] = hexColorStrings;
        }

        await db.collection('products').doc(doc).update(editProductData);

        productC.clear();
        descriptionC.clear();
        priceC.clear();
        categoryC.clear();
        ratingC.clear();
        colorC.clear();
        size!.clear();

        Get.back();
        Get.back();
        return resp = 'success';
      }
    } catch (e) {
      Get.defaultDialog(title: 'Produk Gagal Ditambahkan');
    }
    return resp;
  }

  void deleteProduk({
    required String doc,
  }) async {
    isAlreadyDelete.value = true;

    try {
      Get.back();
      Get.back();
      db.collection("products").doc(doc).delete();
    } on FirebaseException {
      Get.defaultDialog(
          middleText: 'Terjadi Kesalahan Periksa Koneksi Internet Anda');
    } finally {
      isAlreadyDelete.value = false;
    }
  }

  Stream<QuerySnapshot<Object?>>? stream(final listProdukC) {
    return FirebaseFirestore.instance
        .collection('products')
        .where('product_name',
            isGreaterThanOrEqualTo: listProdukC.toLowerCase())
        .where('product_name',
            isLessThanOrEqualTo: '${listProdukC.toLowerCase()}\uf8ff')
        .orderBy('product_name')
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>>? streamAll() {
    return FirebaseFirestore.instance
        .collection('products')
        .orderBy('timestamp')
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>>? streamFilter(String filter) {
    return FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: filter)
        .snapshots();
  }
}
