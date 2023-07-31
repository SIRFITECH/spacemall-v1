import 'dart:async';

import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/domain/on_boarding_model.dart';
import 'package:spacemall/src/features/auth/screens/login/login.dart';
import 'package:spacemall/src/features/auth/screens/on_boarding/on_boarding_page_widget.dart';

class OnBoradingController extends GetxController {
  final controller = LiquidController();
  RxInt currentPage = 0.obs;
  late Timer _timer;

  final pages = [
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: kOnBoardingImage1,
        title: kOnBoardingTitle1,
        subTitle: kOnBoardingSubTitle1,
        counterText: kOnBoardingCounter1,
        bgColor: kOnBoardingPage1Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: kOnBoardingImage2,
        title: kOnBoardingTitle2,
        subTitle: kOnBoardingSubTitle2,
        counterText: kOnBoardingCounter2,
        bgColor: kOnBoardingPage2Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: kOnBoardingImage3,
        title: kOnBoardingTitle3,
        subTitle: kOnBoardingSubTitle3,
        counterText: kOnBoardingCounter3,
        bgColor: kOnBoardingPage3Color,
      ),
    )
  ];

  void setCurrentPage(int activePageIndex) {
    if (activePageIndex == 2) {
      _timer = Timer(
        const Duration(seconds: 3),
        () {
          Get.off(
            () => const Login(),
          );
          _timer.cancel();
        },
      );
    }
    currentPage.value = activePageIndex;
  }

  skip() => controller.jumpToPage(page: pages.length - 1);
  animateToNextSlide() {
    if (controller.currentPage <= 1) {
      int nextpage = controller.currentPage + 1;
      controller.animateToPage(page: nextpage);
    } else if (controller.currentPage == 2) {
      Get.off(
        () => const Login(),
      );
    }
  }
}
