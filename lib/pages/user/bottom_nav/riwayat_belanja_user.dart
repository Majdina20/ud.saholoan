import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/controller/users/riwayat_belanja_user_controller.dart';
import 'package:udsaholoan/constant/component/horizontal_line.dart';
import 'package:udsaholoan/constant/component/theme.dart';

class RiwayatBelanjaUser extends StatelessWidget {
  RiwayatBelanjaUser({super.key});

  final riwayatBelanjaC = Get.put(RiwayatBelanjaUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Riwayat Belanja",
          style: darkTitleText.copyWith(fontWeight: FontWeight.w900, shadows: [
            const BoxShadow(
              color: Color(0x19000000),
              blurRadius: 1,
              blurStyle: BlurStyle.outer,
              offset: Offset(0, 5),
            ),
          ]),
        ),
        centerTitle: true,
        leading: const Icon(
          Icons.arrow_back_rounded,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: riwayatBelanjaC.riwayatBelanja(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.blue,
                ),
              );
            }

            var dataRiwayatBelanja = snapshot.data!.docs;

            return ListView.builder(
              itemCount: dataRiwayatBelanja.length,
              itemBuilder: (context, index) {
                var riwayatBelanjaUser = dataRiwayatBelanja[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // height: 200,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${riwayatBelanjaUser['namaProduk']}'.capitalize!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: darkTitleText,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Image.network(
                            riwayatBelanjaUser['photo'],
                            width: 88,
                            height: 88,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const HorizontalLine(),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ukuran : ",
                                style: darkTitleText,
                              ),
                              Text(
                                "${riwayatBelanjaUser['whatASize']}"
                                    .toUpperCase(),
                                style: darkTitleText,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Warna : ",
                                style: darkTitleText,
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Color(
                                    int.parse(
                                      riwayatBelanjaUser['whatAColor'],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${riwayatBelanjaUser['quantity']} Produk",
                                style: darkTitleText,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '',
                                  style: darkTitleText,
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: 'Total Pesanan: ',
                                    ),
                                    TextSpan(
                                      text: formatCurrency
                                          .format(riwayatBelanjaUser['price']),
                                      style: pinkText,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const HorizontalLine(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
