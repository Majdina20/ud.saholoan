import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/constant/component/custom_card_dashboard.dart';
import 'package:udsaholoan/constant/core/assets/assets.gen.dart';
import 'package:udsaholoan/core.dart';

class DashboardAdmin extends StatelessWidget {
  DashboardAdmin({super.key});

  final dashboardAdminC = Get.put(DashboardAdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15.0,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: dashboardAdminC.streamProdukLength(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CustomCardDashboard(
                      title: 'Produk',
                      quantity: 'Loading...',
                      backgroundColor: basicColor,
                      image: Assets.inventoryIcon.path,
                    );
                  }
                  var lengthProducts = snapshot.data!.docs;
                  return CustomCardDashboard(
                    title: 'Produk',
                    quantity: '${lengthProducts.length}',
                    backgroundColor: basicColor,
                    image: Assets.inventoryIcon.path,
                  );
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: dashboardAdminC.streamMitraLength(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CustomCardDashboard(
                      title: 'Total Customer',
                      quantity: 'Loading...',
                      backgroundColor: darkGreenColor,
                      image: Assets.boyIcon.path,
                    );
                  }

                  var lengthMitra = snapshot.data!.docs;
                  return CustomCardDashboard(
                    title: 'Total Customer',
                    quantity: '${lengthMitra.length}',
                    backgroundColor: darkGreenColor,
                    image: Assets.boyIcon.path,
                  );
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: dashboardAdminC.streamTransaksi('Selesai'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CustomCardDashboard(
                      title: 'Transaksi Selesai',
                      quantity: 'Loading...',
                      backgroundColor: darkBlueColor,
                      image: Assets.receiptLongIcon.path,
                    );
                  }

                  var streamTransaksiS = snapshot.data!.docs;
                  return CustomCardDashboard(
                    title: 'Transaksi Selesai',
                    quantity: '${streamTransaksiS.length}',
                    backgroundColor: darkBlueColor,
                    image: Assets.receiptLongIcon.path,
                  );
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: dashboardAdminC.streamTransaksi('Dalam Proses'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CustomCardDashboard(
                      title: 'Transaksi Dalam Proses',
                      quantity: 'Loading...',
                      backgroundColor: darkJinggaColor,
                      image: Assets.contractEditIcon.path,
                    );
                  }

                  var streamTransaksiDP = snapshot.data!.docs;
                  return CustomCardDashboard(
                    title: 'Transaksi Dalam Proses',
                    quantity: '${streamTransaksiDP.length}',
                    backgroundColor: darkJinggaColor,
                    image: Assets.contractEditIcon.path,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
