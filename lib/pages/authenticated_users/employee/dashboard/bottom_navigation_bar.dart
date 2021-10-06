import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    // return BottomNavigationBar(
    //   currentIndex: 2,
    //   selectedItemColor: primaryColor,
    //   type: BottomNavigationBarType.fixed,
    //   items: const [
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home_repair_service_sharp),
    //       label: 'Hoạt động',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.account_box_outlined),
    //       label: 'Cá nhân',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home),
    //       label: 'Trang chủ',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.history),
    //       label: 'Lịch sử',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.settings),
    //       label: 'Cài đặt',
    //     ),
    //   ],
    // );
    var _selectedIndex = 2;
    return CurvedNavigationBar(
      height: 46,
      index: 2,
      color: primaryLightColor,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: primaryColor,
      onTap: (index) => setState(() {
        _selectedIndex = index;
      }),
      items: [
        Icon(
          Icons.home_repair_service_sharp,
          color: _selectedIndex == 0 ? Colors.white : primaryColor,
        ),
        Icon(
          Icons.account_box_outlined,
          color: _selectedIndex == 1 ? Colors.white : primaryColor,
        ),
        Image.asset(
          imagePath + homePNG,
          height: 30,
          width: 30,
          fit: BoxFit.cover,
        ),
        Icon(
          Icons.history,
          color: _selectedIndex == 3 ? Colors.white : primaryColor,
        ),
        Icon(
          Icons.settings,
          color: _selectedIndex == 4 ? Colors.white : primaryColor,
        ),
      ],
    );
  }
}
