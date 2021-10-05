import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  get kPrimaryLightColor => null;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.only(left: 10),
      width: size.width * 0.62,
      height: 40,
      decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(29),
          border: Border.all(
            color: primaryColor,
            width: 1,
          )),
      child: child,
    );
  }
}
