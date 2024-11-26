import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/controller/users/profile_user_controller.dart';
import 'package:udsaholoan/constant/component/textfield_custom.dart';
import 'package:udsaholoan/constant/component/theme.dart';

class EditProfileUser extends StatefulWidget {
  const EditProfileUser({
    super.key,
    required this.photo,
    required this.namaAdmin,
    required this.noTelpAdmin,
  });

  final String photo;
  final TextEditingController namaAdmin;
  final TextEditingController noTelpAdmin;

  @override
  State<EditProfileUser> createState() => _EditProfileUserState();
}

class _EditProfileUserState extends State<EditProfileUser> {
  final editProfileUserC = Get.put(ProfileUserController());

  Uint8List? _image;
  void selectedImage() async {
    Uint8List? img = await editProfileUserC.pickImage();
    setState(() {
      _image = img;
    });
  }

  void saveAll() async {
    try {
      await editProfileUserC.saveProfile(
        fileGambar: _image!,
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Gagal Menyimpan",
        middleText: 'Ulangi beberapa saat',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    const Expanded(child: Text("Ubah Profil")),
                    GestureDetector(
                      onTap: () async {
                        // saveAll();
                        if (_image != null) {
                          await editProfileUserC.saveProfile(
                            fileGambar: _image,
                          );
                        } else {
                          await editProfileUserC.saveProfile(
                            fileGambar: null,
                            existingImageUrl: widget.photo,
                          );
                        }
                      },
                      child: const Icon(
                        Icons.check,
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              editProfileUserC.isLoading.value
                  ? Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2.5,
                        ),
                        const CircularProgressIndicator(),
                      ],
                    )
                  : Column(
                      children: [
                        Material(
                          color: basicColor,
                          child: InkWell(
                            onTap: () {
                              selectedImage();
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Get.width,
                                  height: 250,
                                ),
                                _image != null && _image!.isNotEmpty
                                    ? CircleAvatar(
                                        radius: 64,
                                        backgroundImage: MemoryImage(_image!),
                                        child: const Padding(
                                          padding: EdgeInsets.only(bottom: 3),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text("Ubah"),
                                          ),
                                        ),
                                      )
                                    : (widget.photo != ''
                                        ? CircleAvatar(
                                            radius: 64,
                                            backgroundImage:
                                                NetworkImage(widget.photo),
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 3),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text("Ubah"),
                                              ),
                                            ),
                                          )
                                        : const CircleAvatar(
                                            radius: 64,
                                            backgroundColor: darkBlueColor,
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.white,
                                            ),
                                          )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFieldCustom(
                            obsecureText: false,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            hintText: 'Ubah Nama',
                            icon: Icons.person,
                            textEditingController: widget.namaAdmin,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFieldCustom(
                            obsecureText: false,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            hintText: 'Ubah No.Handphone',
                            icon: Icons.person,
                            textEditingController: widget.noTelpAdmin,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
