import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/bottom_navigation_bar.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/category.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/top_navigation_bar.dart';

class EmployeeDashBoard extends StatelessWidget {
  const EmployeeDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 130,
              child: TopNavigationBar(size: _size),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  const CategogyCard(),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: GridView.builder(
                        itemCount: 20,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) => const CategoryItem(
                          categoryName: 'Giấy',
                          iconPath: iconPath + paperSvg,
                          isSelected: false,
                        ),
                      ),
                    ),
                  ),
                  const BottomNavigation(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
