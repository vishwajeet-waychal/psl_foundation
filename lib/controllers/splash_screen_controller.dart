import 'dart:async';

import 'package:get/get.dart';
import 'package:psl_foundation/services/InternetConnecivityService.dart';
import 'package:psl_foundation/services/SplashScreenService.dart';
import 'package:psl_foundation/views/bottom_navigation_bar.dart';
import 'package:psl_foundation/views/login_screen.dart';
import 'package:psl_foundation/views/no_internet_screen.dart';


class SplashScreenController extends GetxController {

  @override
  void onInit() {
    super.onInit();

    LoggedInUserService.isUserLoggedIn().then((loggedInUserValue) {
      Timer(const Duration(milliseconds: 3000), () {

        InternetConnectivityService.checkInternet().then((connectivityValue) {
          if (connectivityValue) {
            if (loggedInUserValue) {
              Get.off(() => const PFBottomNavigationBar());
            } else {
              Get.off(() => LoginScreen());
            }
          } else {
            Get.off(() => const NoInternetScreen());
          }
        });

      });
    });
  }

}