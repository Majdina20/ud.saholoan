import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/constant/component/custom_card_profile.dart';
import 'package:udsaholoan/core.dart';

class PengaturanPage extends StatelessWidget {
  PengaturanPage({super.key, required this.doc});

  final pengaturanC = Get.put(HomeAdminC());

  final String doc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: pengaturanC.streamAll(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.blue,
            ),
          );
        }
        final profileAdmin = snapshot.data!.data();
        var pengaturan = profileAdmin as Map<String, dynamic>;
        return CustomCardProfile(
          nama: '${pengaturan['nama_admin']}',
          noTelp: pengaturan['no_telp'],
          profilePicture: pengaturan['profile_picture'],
          onTap: () {
            pengaturanC.nameC.text = pengaturan['nama_admin'];
            pengaturanC.noTelpC.text = pengaturan['no_telp'];
            Get.to(() => PengaturanEditPage(
                  doc: doc,
                  photo: pengaturan['profile_picture'],
                  namaAdmin: pengaturanC.nameC,
                  noTelpAdmin: pengaturanC.noTelpC,
                ));
          },
        );
      },
    );
  }
}
