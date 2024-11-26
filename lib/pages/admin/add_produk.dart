import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/constant/component/textform_description.dart';
import 'package:udsaholoan/constant/core/assets/assets.gen.dart';
import 'package:udsaholoan/core.dart';

class AddProduk extends StatefulWidget {
  const AddProduk(
      {super.key, required this.urlPembayaran, required this.updloadBy});

  final String urlPembayaran;
  final String updloadBy;

  @override
  State<AddProduk> createState() => _AddProdukState();
}

class _AddProdukState extends State<AddProduk> {
  final listProdukC = Get.put(ListProdukController());
  final pickerColors = Picker();

  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  List<Color> currentColors = [];

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);

  Uint8List? _image;
  void selectedImage() async {
    Uint8List? img = await listProdukC.pickImage();
    setState(() {
      _image = img;
    });
  }

  void addProduct() async {
    try {
      await listProdukC.saveData(
        nameProduct: listProdukC.productC.text.toLowerCase(),
        descProduct: listProdukC.descriptionC.text,
        priceProduct: listProdukC.priceC.text,
        categoryProduct: listProdukC.categoryC.text.toLowerCase(),
        rekomendasi: listProdukC.isRekomendasi.value,
        ratingProduct: 3,
        urlPembayaran: widget.urlPembayaran,
        uploadBy: widget.updloadBy,
        fileGambar: _image!,
        colors: currentColors,
        size: listProdukC.size,
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Gagal Menambahkan Produk",
        middleText: 'Harap isi semua data yang dibutuhkan',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambahkan Data"),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: basicColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage(Assets.blankProfile.path),
                          ),
                    Positioned(
                      bottom: 0,
                      left: 84,
                      child: GestureDetector(
                        onTap: () => selectedImage(),
                        child: Image.asset(
                          Assets.addAPhoto.path,
                          width: 37,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  obsecureText: false,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  hintText: 'Nama Produk',
                  icon: Icons.airplay_sharp,
                  textEditingController: listProdukC.productC,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFieldCustom(
                  obsecureText: false,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  hintText: 'Harga Produk',
                  icon: Icons.price_change_outlined,
                  textEditingController: listProdukC.priceC,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFieldCustom(
                  obsecureText: false,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  hintText: 'Kategori Produk',
                  icon: Icons.category_outlined,
                  textEditingController: listProdukC.categoryC,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextformDescription(
                  textEditingController: listProdukC.descriptionC,
                  hintText: 'Deskripsi Produk',
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Obx(
                  () => CheckboxListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    value: listProdukC.isRekomendasi.value,
                    onChanged: (value) => listProdukC.isRekomendasi.toggle(),
                    title: const Text("Di Rekomendasikan"),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: listProdukC.sizeC,
                  decoration: InputDecoration(
                    labelText: 'Ukuran/Size Barang',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        if (listProdukC.sizeC.text.isNotEmpty) {
                          setState(() {
                            listProdukC.size.add(listProdukC.sizeC.text);
                            listProdukC.sizeC.clear();
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: listProdukC.size.map((size) {
                    return Chip(
                      label: Text(size),
                      onDeleted: () {
                        setState(() {
                          listProdukC.size.remove(size);
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: basicColor,
                          title: const Text('Pilih Warna'),
                          content: SingleChildScrollView(
                            child: MultipleChoiceBlockPicker(
                              pickerColors: currentColors,
                              onColorsChanged: changeColors,
                              availableColors: pickerColors.pickerColor,
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Tambahkan'),
                              onPressed: () {
                                setState(() {
                                  currentColor = pickerColor;
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: abuButton,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Tambahkan Warna",
                        style:
                            darkTitleText.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: currentColors.map((color) {
                    return Chip(
                      backgroundColor: color,
                      label: const Text(''),
                      deleteIcon: const Icon(
                        Icons.delete_forever,
                        size: 24.0,
                        color: Colors.black,
                      ),
                      onDeleted: () {
                        setState(() {
                          currentColors.remove(color);
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                ButtonCustom(
                  ontap: () {
                    addProduct();
                  },
                  title: 'Tambahkan',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
