import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/auth/application/on_boarding_controller/on_boarding_controller.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final obController = OnBoradingController();

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            onPageChangeCallback: obController.setCurrentPage,
            pages: obController.pages,
            liquidController: obController.controller,
            slideIconWidget: const Icon(
              Icons.arrow_back_ios,
              color: kMainComplimemtColorLight,
            ),
            enableSideReveal: true,
          ),
          Positioned(
            bottom: 60.0,
            child: OutlinedButton(
              onPressed: () => obController.animateToNextSlide(),
              style: ElevatedButton.styleFrom(
                side: BorderSide(color: kDefaultIconDarkColor),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                foregroundColor: kWhiteLight,
              ),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: kMainComplimemtColorLight, shape: BoxShape.circle),
                child: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () => obController.skip(),
              child: const Text(
                'skip',
                style: TextStyle(color: kMainComplimemtColorLight),
              ),
            ),
          ),
          Obx(
            () => Positioned(
              bottom: 20,
              child: AnimatedSmoothIndicator(
                activeIndex: obController.currentPage.value,
                effect: const WormEffect(
                    activeDotColor: kMainComplimemtColorLight,
                    dotColor: kWhiteDark,
                    dotHeight: 5.0),
                count: obController.pages.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
