import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';

class SingleCartItemWidget extends StatelessWidget {
  const SingleCartItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // AddItemModel stockItem = stockItemBox.get('item_list') ?? null;

    // final media = MediaQuery.of(context);
    // final brightness = media.platformBrightness;
    // final isDarkMood = brightness == Brightness.dark;
    // final screenSize = media.size;
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                offset: const Offset(3, 2),
                blurRadius: 7)
          ]),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: SizedBox(
                width: 200,
                height: 40,
                child:
                    // stockItem.itemPic == null
                    //     ?
                    SvgPicture.asset(
                  kImageIcon,
                  color: kMainColorDark,
                  width: 50,
                  height: 70,
                  fit: BoxFit.scaleDown,
                )
                //     :
                // ClipRRect(
                //     borderRadius: BorderRadius.circular(10),
                //     child: Image.file(stockItem.itemPic!),),
                ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Product Name'),
          ),
          const Text('Product Category'),
          const SizedBox(
            height: 5,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text('Product Category'),
          //     // const SizedBox(
          //     //   width: 5,
          //     // ),
          //     // IconButton(
          //     //     icon: const Icon(Icons.add_shopping_cart), onPressed: () {})
          //   ],
          // ),
        ],
      ),
    );
  }
}
