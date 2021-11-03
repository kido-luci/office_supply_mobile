import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/dashboard/leader_dashboard.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/leader/order_history/leader_order_history.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/period.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInProvider>(context, listen: false);

    return CurvedNavigationBar(
      height: 46,
      index: 3,
      color: primaryLightColor,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: primaryColor,
      onTap: (index) {
        reloadPeriod(signInProvider: signInProvider);
        switch (index) {
          case 0:
            reloadPeriod(signInProvider: signInProvider);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LeaderDashBoard(),
              ),
            );
            break;
          case 1:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LeaderDashBoard(),
              ),
            );
            break;
          case 2:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LeaderDashBoard(),
              ),
            );
            break;
          case 3:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LeaderOrderHistory(),
              ),
            );
            break;
          case 4:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LeaderDashBoard(),
              ),
            );
            break;
        }
      },
      items: [
        Image.asset(
          imagePath + infomationPNG,
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
          imagePath + recentPNG,
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

  reloadPeriod({required SignInProvider signInProvider}) async {
    signInProvider.period = await PeriodService.fetchPeriod(
        departmentId: signInProvider.department!.id,
        jwtToken: signInProvider.auth!.jwtToken);
  }
}
