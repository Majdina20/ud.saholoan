import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/constant/component/custom_card_profile.dart';
import 'package:udsaholoan/controller/users/profile_user_controller.dart';
import 'package:udsaholoan/pages/auth/login.dart';
import 'package:udsaholoan/pages/user/edit_profile_user.dart';
import 'package:udsaholoan/constant/component/theme.dart';

class ProfileUserPage extends StatelessWidget {
  ProfileUserPage({super.key});

  final profileUser = Get.put(ProfileUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: basicColor,
        title: Text(
          "Profile",
          style: darkTitleText,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: profileUser.profileUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.blue,
              ),
            );
          }

          var rawDataProfileUsers = snapshot.data!.data();
          var profileUsers = rawDataProfileUsers as Map<String, dynamic>;
          return Column(
            children: [
              CustomCardProfile(
                nama: profileUsers['nama_pengguna'],
                noTelp: profileUsers['no_telp'],
                profilePicture: profileUsers['profile_picture'],
                onTap: () {
                  profileUser.nameC.text = profileUsers['nama_pengguna'];
                  profileUser.noTelpC.text = profileUsers['no_telp'];
                  Get.to(() => EditProfileUser(
                        photo: profileUsers['profile_picture'],
                        namaAdmin: profileUser.nameC,
                        noTelpAdmin: profileUser.noTelpC,
                      ));
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () async {
                    profileUser.logOut();
                    await FirebaseAuth.instance.signOut();
                    Get.off(() => LoginPage());
                  },
                  child: SizedBox(
                    width: Get.width,
                    height: 50,
                    child: Card(
                      color: basicColor,
                      child: Center(
                        child: Text(
                          "Logout",
                          style: darkTitleText.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
