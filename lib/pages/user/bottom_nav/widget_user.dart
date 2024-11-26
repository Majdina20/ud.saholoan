import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/core.dart';
import 'package:udsaholoan/pages/user/detail_product_page.dart';

class WidgetUserPage extends StatelessWidget {
  WidgetUserPage({super.key});

  final widgetUserC = Get.put(WidgetUserController());
  final homeC = Get.find<HomeUserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rekomendasi Produk UD.SAHOLOAN ",
                style: titleText.copyWith(fontSize: 24),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Container(
                height: 44,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search),
                    ),
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        initialValue: null,
                        decoration: const InputDecoration.collapsed(
                          filled: true,
                          fillColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          hintText: "Search",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () => homeC.currentIndex.value = 0,
                        onChanged: (value) {
                          // widgetUserC.searchQuery.value = value;
                          // widgetUserC.filter.value = 'All';
                        },
                        onFieldSubmitted: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                  stream: widgetUserC.produkRekomendasi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.blue,
                        ),
                      );
                    }

                    var dataAllProduct = snapshot.data!.docs;

                    return Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 270,
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 6,
                        ),
                        itemCount: dataAllProduct.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var allProduct = dataAllProduct[index];

                          return GridViewProducts(
                            photo: allProduct['photo'],
                            onTap: () {
                              List<String> sizes = allProduct['size'] != null
                                  ? List<String>.from(allProduct['size'])
                                  : [];
                              List<String> colors = allProduct['colors'] != null
                                  ? List<String>.from(allProduct['colors'])
                                  : [];

                              Get.to(
                                () => DetailProdukPage(
                                  image: allProduct['photo'],
                                  productName: allProduct['product_name'],
                                  price: allProduct['price'],
                                  desc: allProduct['description'],
                                  warna: colors,
                                  ukuran: sizes,
                                  nomorWa: allProduct['upload_by'],
                                ),
                              )!
                                  .then(
                                (value) {
                                  homeC.isOrder.value = false;
                                  homeC.counter.value = 1;
                                  homeC.pembayaranVia.value = '';
                                  homeC.colors.value = '';
                                  homeC.size.value = '';
                                },
                              );
                            },
                          );
                        },
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
