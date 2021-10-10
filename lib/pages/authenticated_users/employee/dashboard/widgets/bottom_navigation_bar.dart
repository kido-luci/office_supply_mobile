import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/config/themes.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 46,
      index: 2,
      color: primaryLightColor,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: primaryColor,
      onTap: (index) => setState(() {
        index = index;
      }),
      items: [
        Image.asset(
          imagePath + recentPNG,
          height: 20,
          width: 20,
          fit: BoxFit.cover,
        ),
        Image.asset(
          imagePath + profilePNG,
          height: 20,
          width: 20,
          fit: BoxFit.cover,
        ),
        Image.asset(
          imagePath + homePNG,
          height: 20,
          width: 20,
          fit: BoxFit.cover,
        ),
        Image.asset(
          imagePath + infomationPNG,
          height: 20,
          width: 20,
          fit: BoxFit.cover,
        ),
        Image.asset(
          imagePath + settingPNG,
          height: 20,
          width: 20,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
