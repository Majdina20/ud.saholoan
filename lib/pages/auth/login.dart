import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/core.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final loginC = Get.put(LoginController());

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat Datang",
                      style: titleText,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 77),
                      child: Text(
                        "di UD-SAHOLOAN",
                        style: titleText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 77,
                ),
                TextFieldCustom(
                  textEditingController: loginC.emailC,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  hintText: 'Email',
                  filled: true,
                  colorFilled: greyColor,
                  icon: Icons.person,
                ),
                const SizedBox(
                  height: 31.0,
                ),
                TextFieldCustom(
                  textEditingController: loginC.passwordC,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obsecureText: true,
                  filled: true,
                  colorFilled: greyColor,
                  hintText: 'Password',
                  icon: Icons.lock,
                ),
                const SizedBox(
                  height: 9.0,
                ),
                Obx(() => CheckboxListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      value: loginC.rememberme.value,
                      onChanged: (value) => loginC.rememberme.toggle(),
                      title: const Text("Remember Me"),
                      controlAffinity: ListTileControlAffinity.leading,
                    )),
                Obx(
                  () => ButtonCustom(
                    ontap: () {
                      loginC.signInwithEmail(
                        loginC.emailC.text,
                        loginC.passwordC.text,
                        loginC.rememberme.value,
                      );
                    },
                    title: loginC.isLoading.value ? 'Loading...' : 'Login',
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Belum Punya Akun?",
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => RegisterUser());
                      },
                      child: Text(
                        "Register Sekarang",
                        style: basicText.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: basicColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
