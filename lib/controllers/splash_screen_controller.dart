import 'dart:async';

import 'package:get/get.dart';
import 'package:psl_foundation/services/SplashScreenService.dart';
import 'package:psl_foundation/views/bottom_navigation_bar.dart';
import 'package:psl_foundation/views/login_screen.dart';


class SplashScreenController extends GetxController {

  @override
  void onInit() {
    super.onInit();

    LoggedInUserService.isUserLoggedIn().then((value) {
      Timer(const Duration(milliseconds: 3000), () {
        if (value) {
          Get.off(() => const PFBottomNavigationBar());
        } else {
          Get.off(() => LoginScreen());
        }
      });
    });
  }

}