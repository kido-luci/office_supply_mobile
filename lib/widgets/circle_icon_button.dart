import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton(
      {Key? key,
      required this.onTap,
      required this.margin,
      required this.iconData})
      : super(key: key);
  final VoidCallback onTap;
  final EdgeInsets margin;
  final IconData iconData;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          width: 30,
          height: 30,
          margin: margin,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: primaryLightColorTransparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            color: Colors.white,
            size: 12,
          ),
        ),
      );
}
