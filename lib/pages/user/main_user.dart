import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/constant/core/assets/assets.gen.dart';
import 'package:udsaholoan/core.dart';

class MainUser extends StatelessWidget {
  MainUser({super.key});

  final homeUserC = Get.put(HomeUserController());

  Widget body() {
    switch (homeUserC.currentIndex.value) {
      case 0:
        return HomeUserPage();
      case 1:
        return RiwayatBelanjaUser();
      case 2:
        return WidgetUserPage();
      case 3:
        return ProfileUserPage();

      default:
        return HomeUserPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          padding: const EdgeInsets.all(0),
          child: BottomNavigationBar(
              elevation: 5,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                homeUserC.currentIndex.value = value;
              },
              items: [
                BottomNavigationBarItem(
                  label: '',
                  icon: homeUserC.currentIndex.value == 0
                      ? Image.asset(
                          Assets.homeIcon.path,
                          fit: BoxFit.cover,
                          width: 24,
                          color: basicColor,
                        )
                      : Image.asset(
                          Assets.homeIcon.path,
                          width: 24,
                          fit: BoxFit.cover,
                        ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: homeUserC.currentIndex.value == 1
                      ? Image.asset(
                          Assets.libraryBooks.path,
                          width: 24,
                          fit: BoxFit.cover,
                          color: basicColor,
                        )
                      : Image.asset(
                          Assets.libraryBooks.path,
                          width: 24,
                          fit: BoxFit.cover,
                        ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: homeUserC.currentIndex.value == 2
                      ? Image.asset(
                          Assets.widgets.path,
                          width: 24,
                          fit: BoxFit.cover,
                          color: basicColor,
                        )
                      : Image.asset(
                          Assets.widgets.path,
                          width: 24,
                          fit: BoxFit.cover,
                        ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: homeUserC.currentIndex.value == 3
                      ? Image.asset(
                          Assets.accountCircle.path,
                          width: 24,
                          fit: BoxFit.cover,
                          color: basicColor,
                        )
                      : Image.asset(
                          Assets.accountCircle.path,
                          width: 24,
                          fit: BoxFit.cover,
                        ),
                ),
              ]),
        ),
      ),
      body: Obx(() => body()),
    );
  }
}
