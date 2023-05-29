import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/image_strings.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    // final brightness = media.platformBrightness;
    // final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Out Screen'),
        centerTitle: true,
      ),
      body: Container(
        // color: isDarkMood?:,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kBackGroundCart),
            fit: BoxFit.contain,
          ),
        ),
        child: Text('Check Out Screen'),
      ),
    );
  }
}
