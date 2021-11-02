import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/paths.dart';

class Background extends StatelessWidget {
  const Background({Key? key, required this.size}) : super(key: key);
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              imagePath + mainTopPNG,
              height: size.height * 0.15,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              imagePath + loginBottomPNG,
              height: size.height * 0.15,
            ),
          )
        ],
      ),
    );
  }
}
