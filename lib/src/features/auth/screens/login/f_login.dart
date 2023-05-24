import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/sizes.dart';

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
                onTap: () {},
                child: const Image(
                  height: kFImageHeight,
                  width: kFImageWidth,
                  image: AssetImage(kFaceBookLogin),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Image(
                  height: kFImageHeight,
                  width: kFImageWidth,
                  image: AssetImage(kGmailLogin),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Image(
                  height: kFImageHeight,
                  width: kFImageWidth,
                  image: AssetImage(kTwitterLogin),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Image(
                  height: kFImageHeight,
                  width: kFImageWidth,
                  image: AssetImage(kInstagramLogin),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
