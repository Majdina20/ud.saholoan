import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/controller/auth/register_user_controller.dart';
import 'package:udsaholoan/pages/auth/login.dart';
import 'package:udsaholoan/constant/component/button_custom.dart';
import 'package:udsaholoan/constant/component/textfield_custom.dart';
import 'package:udsaholoan/constant/component/theme.dart';

class RegisterUser extends StatelessWidget {
  RegisterUser({super.key});

  final registerUserC = Get.put(RegisterUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 63),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Buat Akun",
                  style: titleText,
                ),
                const SizedBox(
                  height: 36.0,
                ),
                TextFieldCustom(
                  textEditingController: registerUserC.usernameC,
                  filled: true,
                  colorFilled: greyColor,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  hintText: 'Nama Pengguna',
                  icon: Icons.person,
                ),
                const SizedBox(
                  height: 31.0,
                ),
                TextFieldCustom(
                  textEditingController: registerUserC.phoneC,
                  filled: true,
                  colorFilled: greyColor,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  hintText: 'No Telp',
                  icon: Icons.person,
                ),
                const SizedBox(
                  height: 31.0,
                ),
                TextFieldCustom(
                  textEditingController: registerUserC.emailC,
                  filled: true,
                  colorFilled: greyColor,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  hintText: 'Email',
                  icon: Icons.person,
                ),
                const SizedBox(
                  height: 31.0,
                ),
                TextFieldCustom(
                  textEditingController: registerUserC.passwordC,
                  obsecureText: true,
                  filled: true,
                  colorFilled: greyColor,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  hintText: 'Password',
                  icon: Icons.lock,
                ),
                const SizedBox(
                  height: 9.0,
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Obx(
                  () => ButtonCustom(
                    ontap: () {
                      registerUserC.signUpWithUser(
                        registerUserC.emailC.text,
                        registerUserC.passwordC.text,
                        registerUserC.usernameC.text,
                        registerUserC.phoneC.text,
                      );
                    },
                    title: registerUserC.isLoading.value
                        ? 'Loading...'
                        : 'Buat Akun',
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Sudah punya akun?",
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
                    GestureDetector(
                      onTap: () => Get.off(() => LoginPage()),
                      child: Text(
                        "Silahkan Login",
                        style: basicText.copyWith(
                          fontWeight: FontWeight.bold,
                          color: basicColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
