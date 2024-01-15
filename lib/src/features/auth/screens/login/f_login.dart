import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

import '../../../../constants/image_strings.dart';

class FLogin extends StatelessWidget {
  const FLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Sign in with:',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: kFormHeight - 10,
              right: kFormHeight - 10,
              bottom: kFormHeight),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  spaceMallSnackBar(
                      'Coming soon...',
                      'Please Login Using your Phone number',
                      kWhiteLight,
                      kRedColor);
                  // AuthRepo.instance.signInWithGoogle();
                },
                child:
                    // Text('Google')
                    const Image(
                  height: kFImageHeight,
                  width: kFImageWidth,
                  image: AssetImage(kGmailLogin),
                ),
              ),
              GestureDetector(
                onTap: () {
                  spaceMallSnackBar(
                      'Coming soon...',
                      'Please Login Using your Phone number',
                      kWhiteLight,
                      kRedColor);
                  // AuthRepo.instance.signInWithFacebook();
                },
                child:
                    // Text('Facebook'),
                    const Image(
                  height: kFImageHeight,
                  width: kFImageWidth,
                  image: AssetImage(kFaceBookLogin),
                ),
              ),
              GestureDetector(
                onTap: () {
                  spaceMallSnackBar(
                      'Coming soon...',
                      'Please Login Using your Phone number',
                      kWhiteLight,
                      kRedColor);
                  // AuthRepo.instance.signInWithTwitter();
                },
                child: const Image(
                  height: kFImageHeight,
                  width: kFImageWidth,
                  image: AssetImage(kTwitterLogin),
                ),
              ),
              GestureDetector(
                onTap: () {
                  spaceMallSnackBar(
                      'Coming soon...',
                      'Please Login Using your Phone number',
                      kWhiteLight,
                      kRedColor);
                  // AuthRepo.instance.signInWithInsta();
                },
                // child: Text('Instagram'),
                child: const Image(
                  height: kFImageHeight,
                  width: kFImageWidth,
                  image: AssetImage(kInstagramLogin),
                ),
              ),
              GestureDetector(
                onTap: () {
                  spaceMallSnackBar(
                      'Coming soon...',
                      'Please Login Using your Phone number',
                      kWhiteLight,
                      kRedColor);
                  // AuthRepo.instance.signInWithMetaMask();
                },
                child: const Image(
                  height: kFImageHeight,
                  width: kFImageWidth,
                  image: AssetImage(kMetaMaskLogin),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
