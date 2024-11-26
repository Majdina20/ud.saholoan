import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/constant/core/assets/assets.gen.dart';
import 'package:udsaholoan/core.dart';
import 'package:udsaholoan/pages/admin/transaksi_dalamproses_page.dart';
import 'package:udsaholoan/pages/admin/transaksi_selesai_page.dart';

class HomeAdmin extends StatelessWidget {
  HomeAdmin({super.key});

  final homeAdminC = Get.put(HomeAdminC());
  final loginC = Get.put(LoginController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Widget tabBarIndex() {
      switch (homeAdminC.currentDrawer.value) {
        case 0:
          return DashboardAdmin();
        case 1:
          return ListProdukPageAdmin(
            urlPembayaran: homeAdminC.urlPembayaran.value,
            updloadBy: FirebaseAuth.instance.currentUser!.uid,
          );
        case 2:
          return TransaksiSelesaiPage();
        case 3:
          return TransaksiDalamprosesPage();
        case 4:
          return PengaturanPage(
            doc: FirebaseAuth.instance.currentUser!.uid,
          );
        default:
          return DashboardAdmin();
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: basicColor,
        leading: GestureDetector(
          onTap: () => _scaffoldKey.currentState?.openDrawer(),
          child: Image.asset(
            Assets.menuIcon.path,
          ),
        ),
        title: Text(
          "UD-SAHOLOAN",
          style: titleText,
        ),
      ),
      drawer: Drawer(
        backgroundColor: cloudlColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawerItemUtils(
                    ontap: () {
                      homeAdminC.currentDrawer.value = 0;
                      Get.back();
                    },
                    icon: Assets.homeIcon.path,
                    title: 'Dashboard',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DrawerItemUtils(
                    ontap: () {
                      homeAdminC.currentDrawer.value = 1;
                      Get.back();
                    },
                    icon: Assets.inventoryIcon.path,
                    title: 'Daftar Produk',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DrawerItemUtils(
                    ontap: () async {
                      homeAdminC.currentDrawer.value = 2;
                      Get.back();
                    },
                    icon: Assets.receiptLongIcon.path,
                    title: 'Transaksi Selesai',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DrawerItemUtils(
                    ontap: () async {
                      homeAdminC.currentDrawer.value = 3;
                      Get.back();
                    },
                    icon: Assets.contractEditIcon.path,
                    title: 'Transaksi Dalam Proses',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DrawerItemUtils(
                    ontap: () async {
                      homeAdminC.currentDrawer.value = 4;
                      Get.back();
                    },
                    icon: Assets.userIcon.path,
                    title: 'Pengaturan',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DrawerItemUtils(
                    ontap: () async {
                      loginC.logOut();
                      await FirebaseAuth.instance.signOut();
                      Get.off(() => LoginPage());
                    },
                    icon: Assets.logout.path,
                    title: 'Keluar',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Obx(() => tabBarIndex()),
    );
  }
}
