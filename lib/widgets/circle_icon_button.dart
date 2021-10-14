import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    Key? key,
    required this.onTap,
    required this.margin,
    required this.iconData,
    required this.size,
    required this.iconColor,
    required this.backgroundColor,
  }) : super(key: key);
  final VoidCallback onTap;
  final EdgeInsets margin;
  final IconData iconData;
  final double size;
  final Color iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          margin: margin,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            color: iconColor,
            size: 12,
          ),
        ),
      );
}
