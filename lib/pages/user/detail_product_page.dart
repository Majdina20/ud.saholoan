import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/constant/component/custom_button.dart';
import 'package:udsaholoan/constant/extension/int_ext.dart';
import 'package:udsaholoan/core.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailProdukPage extends StatelessWidget {
  final String image;
  final String productName;
  final String price;
  final String desc;
  final List<String> warna;
  final List<String> ukuran;
  final String nomorWa;

  final homeC = Get.find<HomeUserController>();

  DetailProdukPage({
    super.key,
    required this.image,
    required this.productName,
    required this.price,
    required this.desc,
    required this.warna,
    required this.ukuran,
    required this.nomorWa,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk Detail"),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView(
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
            homeC.isOrder.value
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Get.width,
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Pilih payment Anda",
                          style: darkTitleText.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomButton(
                                onTap: () => homeC.pembayaranVia.value = 'COD',
                                title: 'COD',
                                color: homeC.pembayaranVia.value == 'COD'
                                    ? basicColor
                                    : abuButton,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: CustomButton(
                                onTap: () => homeC.pembayaranVia.value = 'CASH',
                                title: 'CASH',
                                color: homeC.pembayaranVia.value == 'CASH'
                                    ? basicColor
                                    : abuButton,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 14),
                        CustomButton(
                          onTap: () async {
                            Map<String, dynamic>? admin =
                                await homeC.getNomorDana(idAdmin: nomorWa);

                            launchUrl(
                                Uri.parse(
                                    'https://wa.me/${admin!['no_telp']}?text=${Uri.encodeComponent("Bukti Pembayaran dll")}'),
                                mode: LaunchMode.externalApplication);
                          },
                          title: 'WhatsApp',
                        ),
                        const SizedBox(height: 14),
                        CustomButton(
                          onTap: () async {
                            Map<String, dynamic>? userData =
                                await homeC.getNomorUser();
                            homeC.goToCart(
                              photo: image,
                              namaProduk: productName,
                              namaToko: 'UD Sihaloan',
                              deskripsiProduk: desc,
                              // whatAColor: homeC.,
                              // whatASize: ukuran,
                              // quantity: quantity,
                              price: int.parse(price) * homeC.counter.value,
                              // pembayaranVia: pembayaranVia,
                              noHpPembeli: userData!['no_telp'],
                            );
                          },
                          title: 'Selesai',
                        ),
                      ],
                    ),
                  )
                : Padding(
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
                          Text(
                            int.parse(price).currencyFormatRp,
                            style: darkTitleText.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
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
                          const SizedBox(height: 10),
                          Container(
                            width: Get.width,
                            height: 1,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomButton(
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: 'Pilih Ukuran',
                                      content: Wrap(
                                        spacing: 8.0,
                                        runSpacing: 8.0,
                                        children: ukuran.map(
                                          (size) {
                                            return Obx(
                                              () => GestureDetector(
                                                onTap: () =>
                                                    homeC.size.value = size,
                                                child: Chip(
                                                  backgroundColor:
                                                      homeC.size.value == size
                                                          ? basicColor
                                                          : Colors.white,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 12,
                                                  ),
                                                  label: Text(
                                                    size,
                                                    style:
                                                        darkTitleText.copyWith(
                                                      color: homeC.size.value ==
                                                              size
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    );
                                  },
                                  title: 'Pilih Ukuran',
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: CustomButton(
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: 'Pilih Warna',
                                      content: Wrap(
                                        spacing: 8.0,
                                        runSpacing: 8.0,
                                        children: warna.map(
                                          (color) {
                                            return Obx(
                                              () => GestureDetector(
                                                onTap: () =>
                                                    homeC.colors.value = color,
                                                child: Chip(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 12,
                                                  ),
                                                  backgroundColor:
                                                      Color(int.parse(color)),
                                                  label: homeC.colors.value ==
                                                          color
                                                      ? const Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                          weight: 10,
                                                        )
                                                      : const Text(''),
                                                ),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    );
                                  },
                                  title: 'Pilih Warna',
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("QUANTITY"),
                              SizedBox(
                                width: 137,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        homeC.decrement();
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        size: 24.0,
                                      ),
                                    ),
                                    Text(
                                      homeC.counter.value.toString(),
                                      style:
                                          darkTitleText.copyWith(fontSize: 16),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        homeC.increment();
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        size: 24.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomButton(
                            onTap: () => homeC.isOrder.value = true,
                            title: 'Bayar',
                          ),
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
