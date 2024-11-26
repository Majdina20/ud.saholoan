import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/core.dart';
import 'package:udsaholoan/pages/admin/detail_produk.dart';

class ListProdukPageAdmin extends StatelessWidget {
  ListProdukPageAdmin(
      {super.key, required this.urlPembayaran, required this.updloadBy});

  final listProdukC = Get.put(ListProdukController());

  final String urlPembayaran;
  final String updloadBy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cloudlColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Produk UD. SAHOLOAN ",
                        style: darkTitleText.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(75),
                  ),
                  border: Border.all(
                    width: 1.0,
                    color: greyColor,
                  ),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search),
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: null,
                        decoration: InputDecoration.collapsed(
                          filled: true,
                          fillColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          hintText: "Search",
                          hintStyle: darkTitleText.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (value) {
                          listProdukC.searchQuery.value = value;
                          listProdukC.filter.value = 'All';
                          print(listProdukC.filter.value);
                        },
                        onFieldSubmitted: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Material(
                    color: basicColor,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () {
                        // listProdukC.addProducts();
                        Get.to(() => AddProduk(
                                  urlPembayaran: urlPembayaran,
                                  updloadBy: updloadBy,
                                ))!
                            .then((value) =>
                                listProdukC.isRekomendasi.value = false);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 115,
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add,
                                size: 24.0,
                                color: darkColor,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "Tambah",
                                style: darkTitleText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Obx(
                () => StreamBuilder<QuerySnapshot>(
                  stream: listProdukC.filter.value == 'All'
                      ? listProdukC.stream(
                          listProdukC.searchQuery.value,
                        )
                      : listProdukC.streamFilter(listProdukC.filter.value),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.blue,
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const SizedBox();
                    }

                    var products = snapshot.data!.docs;

                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 200,
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 6,
                      ),
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        var product = products[index];
                        var data = product.data() as Map<String, dynamic>;
                        // String productName = data['product_name'];
                        return GestureDetector(
                          onTap: () {
                            List<String> colors = data['colors'] != null
                                ? List<String>.from(data['colors'])
                                : [];
                            List<int> intColors = colors.map((color) {
                              return int.parse(color.substring(2), radix: 16);
                            }).toList();

                            List<String> sizes =
                                List<String>.from(data['size'] ?? []);

                            listProdukC.productC.text = data['product_name'];
                            listProdukC.descriptionC.text = data['description'];
                            listProdukC.priceC.text = data['price'];
                            listProdukC.categoryC.text = data['category'];
                            Get.to(
                              () => DetailProduk(
                                doc: product.id,
                                image: data['photo'],
                                productName: data['product_name'],
                                price: data['price'],
                                desc: data['description'],
                                isRekomendasi: data['rekomendasi'],
                                namaProdukC: listProdukC.productC,
                                priceProdukC: listProdukC.priceC,
                                descProdukC: listProdukC.descriptionC,
                                categoryProdukC: listProdukC.categoryC,
                                warna: intColors,
                                ukuran: sizes,
                                onTapDelete: () {
                                  listProdukC.isAlreadyDelete.value
                                      ? Get.defaultDialog(
                                          title: 'Hapus Produk?',
                                          content: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : Get.defaultDialog(
                                          title: 'Hapus Produk',
                                          middleText:
                                              'Produk ini akan terhapus',
                                          onCancel: () => Get.back(),
                                          textCancel: 'Batal',
                                          textConfirm: 'Hapus',
                                          confirmTextColor: Colors.white,
                                          onConfirm: () =>
                                              listProdukC.deleteProduk(
                                            doc: product.id,
                                          ),
                                        );
                                },
                              ),
                            )!
                                .then((value) {
                              listProdukC.productC.clear();
                              listProdukC.descriptionC.clear();
                              listProdukC.priceC.clear();
                              listProdukC.categoryC.clear();
                            });
                          },
                          child: Container(
                            alignment: Alignment.topCenter,
                            height: 140,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: data['photo'] != null
                                  ? Image.network(
                                      data['photo'],
                                      width: 165,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/contoh.png",
                                      width: 165,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
