import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:psl_foundation/views/splash_screen.dart';
import 'package:psl_foundation/views/widgets/custom_raised_button.dart';

import '../controllers/splash_screen_controller.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: SizedBox(
                height: Get.height - Get.statusBarHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/lottie/no-wifi.json'
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'No internet connection',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: PFRaisedButton(
                        title: 'Retry',
                        onPressed: () {
                          Get.delete<SplashScreenController>();
                          Get.off(() => SplashScreen());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
