import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/constant/extension/int_ext.dart';
import 'package:udsaholoan/core.dart';

class DetailProduk extends StatelessWidget {
  final String image;
  final String productName;
  final String price;
  final String desc;
  final String doc;
  final bool isRekomendasi;
  final List<int> warna;
  final List<String> ukuran;
  final TextEditingController namaProdukC;
  final TextEditingController descProdukC;
  final TextEditingController priceProdukC;
  final TextEditingController categoryProdukC;
  final dynamic onTapDelete;
  const DetailProduk({
    super.key,
    required this.image,
    required this.productName,
    required this.price,
    required this.desc,
    required this.warna,
    required this.ukuran,
    required this.categoryProdukC,
    required this.doc,
    required this.namaProdukC,
    required this.descProdukC,
    required this.priceProdukC,
    required this.onTapDelete,
    required this.isRekomendasi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk Detail"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => EditProduk(
                    photo: image,
                    namaProduk: namaProdukC,
                    descProduk: descProdukC,
                    priceProduk: priceProdukC,
                    categoryProduk: categoryProdukC,
                    doc: doc,
                    urlPembayaran: '',
                    colors: warna,
                    size: ukuran,
                  ));
            },
            child: const Icon(
              Icons.edit,
              size: 24.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: onTapDelete,
              child: const Icon(
                Icons.delete,
                size: 24.0,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: Image.network(
              image,
              width: 195,
              // height: 220,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName.capitalize!,
                    style: darkTitleText.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        int.parse(price).currencyFormatRp,
                        style: darkTitleText.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      isRekomendasi
                          ? ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Colors.amber, Colors.red],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: const Text(
                                "Rekomendasi",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: Get.width,
                    height: 1,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    desc,
                    style: darkTitleText.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Ukuran",
                    style: darkTitleText.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  ukuran.isEmpty
                      ? Text(
                          "Ukuran Belum Ditambahkan",
                          style: darkTitleText.copyWith(
                            fontSize: 16,
                          ),
                        )
                      : Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: ukuran.map((size) {
                            return Chip(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              label: Text(size),
                            );
                          }).toList(),
                        ),
                  const SizedBox(height: 20),
                  Text(
                    "Warna yang Tersedia",
                    style: darkTitleText.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  warna.isEmpty
                      ? Text(
                          "Warna Belum Ditambahkan",
                          style: darkTitleText.copyWith(
                            fontSize: 16,
                          ),
                        )
                      : Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: warna.map((color) {
                            return Chip(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              backgroundColor: Color(color),
                              label: const Text(''),
                            );
                          }).toList(),
                        ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
