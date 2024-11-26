import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/constant/component/textform_description.dart';
import 'package:udsaholoan/constant/core/assets/assets.gen.dart';
import 'package:udsaholoan/core.dart';

class EditProduk extends StatefulWidget {
  const EditProduk({
    super.key,
    required this.photo,
    required this.namaProduk,
    required this.descProduk,
    required this.priceProduk,
    required this.categoryProduk,
    required this.doc,
    required this.urlPembayaran,
    required this.colors,
    required this.size,
  });

  final String doc;
  final String photo;
  final String urlPembayaran;
  final TextEditingController namaProduk;
  final TextEditingController descProduk;
  final TextEditingController priceProduk;
  final TextEditingController categoryProduk;
  final List<int> colors;
  final List<String> size;

  @override
  State<EditProduk> createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  Uint8List? _image;
  final listProdukC = Get.put(ListProdukController());
  final tesColor = Picker();

  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void selectedImage() async {
    Uint8List? img = await listProdukC.pickImage();
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Color> currentColors = [];

    print(currentColors);

    void changeColors(List<Color> colors) =>
        setState(() => currentColors = colors);

    List<Color> convertedColors =
        widget.colors.map((colorValue) => Color(colorValue)).toList();
    List<String> convertedSizeToList =
        widget.size.map((sizeValue) => sizeValue).toList();
    List<String> nilaiSize = listProdukC.size = convertedSizeToList;
    List<Color> nilaiColor = currentColors = convertedColors;

    void clearInputs() {
      widget.namaProduk.clear();
      widget.descProduk.clear();
      widget.priceProduk.clear();
      widget.categoryProduk.clear();
      currentColors.clear();
      listProdukC.size.clear();
    }

    Future<void> editDataWithImage() async {
      await listProdukC.editData(
        doc: widget.doc,
        nameProduct: widget.namaProduk.text,
        descProduct: widget.descProduk.text,
        priceProduct: widget.priceProduk.text,
        rekomendasi: listProdukC.isRekomendasi.value,
        categoryProduct: widget.categoryProduk.text,
        ratingProduct: 3,
        urlPembayaran: widget.urlPembayaran,
        fileGambar: _image!,
        colors: nilaiColor,
        size: nilaiSize,
      );
    }

    Future<void> editDataWithoutImage() async {
      await listProdukC.editData(
        doc: widget.doc,
        nameProduct: widget.namaProduk.text,
        descProduct: widget.descProduk.text,
        priceProduct: widget.priceProduk.text,
        categoryProduct: widget.categoryProduk.text,
        rekomendasi: listProdukC.isRekomendasi.value,
        ratingProduct: 3,
        urlPembayaran: widget.urlPembayaran,
        fileGambar: null,
        existingImageUrl: widget.photo,
        colors: nilaiColor,
        size: nilaiSize,
      );
    }

    Future<void> handleEditData() async {
      final image = _image;
      if (image != null) {
        await editDataWithImage();
      } else {
        await editDataWithoutImage();
      }
      clearInputs();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Produk"),
        centerTitle: true,
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
                            backgroundImage: NetworkImage(widget.photo),
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
                  textEditingController: widget.namaProduk,
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
                  textEditingController: widget.priceProduk,
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
                  textEditingController: widget.categoryProduk,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextformDescription(
                  textEditingController: widget.descProduk,
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
                            widget.size.add(listProdukC.sizeC.text);
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
                  children: widget.size.map((size) {
                    return Chip(
                      label: Text(size),
                      onDeleted: () {
                        setState(() {
                          widget.size.remove(size);
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
                          title: const Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: MultipleChoiceBlockPicker(
                              // cc
                              pickerColors: currentColors,
                              onColorsChanged: changeColors,
                              availableColors: tesColor.pickerColor,
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Tambahkan'),
                              onPressed: () {
                                setState(() {
                                  currentColor = pickerColor;
                                  List<int> colorValues = currentColors
                                      .map((color) => color.value)
                                      .toList();
                                  widget.colors.addAll(colorValues);
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
                  children: widget.colors.map((color) {
                    return Chip(
                      backgroundColor: Color(color),
                      label: const Text(''),
                      deleteIcon: const Icon(
                        Icons.delete_forever,
                        size: 24.0,
                        color: Colors.black,
                      ),
                      onDeleted: () {
                        setState(() {
                          widget.colors.remove(color);
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                ButtonCustom(ontap: () => handleEditData(), title: 'Tambahkan'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
