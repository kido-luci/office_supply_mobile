// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ManagerBottomNav extends StatelessWidget {
  const ManagerBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on_outlined),
          label: 'Period',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          label: 'Order request',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.of(context).pushReplacementNamed('/list_period');
            break;
          case 2:
            Navigator.of(context).pushReplacementNamed('/profile');
            break;
          default:
        }
      },
    );
  }
}
