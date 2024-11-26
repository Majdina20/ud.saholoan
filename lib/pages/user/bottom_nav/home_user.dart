import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/constant/core/assets/assets.gen.dart';
import 'package:udsaholoan/controller/users/home_user_controller.dart';
import 'package:udsaholoan/pages/user/detail_product_page.dart';
import 'package:udsaholoan/constant/component/gridview_products.dart';
import 'package:udsaholoan/constant/component/theme.dart';

class HomeUserPage extends StatelessWidget {
  HomeUserPage({super.key});

  final homeUserC = Get.put(HomeUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {},
          child: Image.asset(
            Assets.menuIcon.path,
          ),
        ),
        backgroundColor: basicColor,
        title: Text(
          "UD-SAHOLOAN",
          style: titleText,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Produk UD. SAHOLOAN ",
                style: titleText.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 16.0,
              ),
              // search Bar
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
                        onChanged: (value) {
                          homeUserC.searchQuery.value = value;
                          homeUserC.filter.value = 'All';
                        },
                        onFieldSubmitted: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Obx(
                () => StreamBuilder<QuerySnapshot>(
                  stream: homeUserC.filter.value == 'All'
                      ? homeUserC.allProduct(
                          homeUserC.searchQuery.value,
                        )
                      : homeUserC.productFilter(homeUserC.filter.value),
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
                                  homeUserC.isOrder.value = false;
                                  homeUserC.counter.value = 1;
                                  homeUserC.pembayaranVia.value = '';
                                  homeUserC.colors.value = '';
                                  homeUserC.size.value = '';
                                },
                              );
                            },
                          );
                        },
                      ),
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
