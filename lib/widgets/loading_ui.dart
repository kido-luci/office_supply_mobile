import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:office_supply_mobile_master/config/themes.dart';

class LoadingUI extends StatelessWidget {
  const LoadingUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Container(
      height: _size.height,
      width: _size.width,
      alignment: Alignment.center,
      color: Colors.white30,
      child: LoadingBouncingGrid.square(
        backgroundColor: primaryColor,
        inverted: true,
        size: 50,
      ),
    );
  }
}
