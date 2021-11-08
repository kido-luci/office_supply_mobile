import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/config/router.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/period.dart';
import 'package:office_supply_mobile_master/widgets/circle_icon_button.dart';
import 'package:provider/provider.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInProvider signInProvider =
        Provider.of<SignInProvider>(context, listen: false);

    return Stack(
      children: [
        backgroundImage(imagePath + sweetHomePNG),
        backgroundColor(primaryLightColorTransparent),
        CircleIconButton(
          onTap: () {
            reloadPeriod(signInProvider: signInProvider);
            Navigator.of(context).pushReplacementNamed(employeeDashboardRouter);
          },
          margin: const EdgeInsets.only(top: 40, left: 10),
          iconData: Icons.arrow_back_ios,
          size: 30,
          iconColor: Colors.white,
          backgroundColor: primaryLightColorTransparent,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: Text(
              'Thông tin đơn hàng',
              style: h5.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  notificationButton(VoidCallback onTap) => InkWell(
        onTap: onTap,
        child: const Icon(
          Icons.notifications_active_outlined,
          color: primaryLightColor,
          size: 15,
        ),
      );

  backgroundImage(String photoUrl) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(photoUrl),
            fit: BoxFit.cover,
          ),
        ),
      );

  backgroundColor(Color color) => Container(
        decoration: BoxDecoration(
          color: color,
        ),
      );

  reloadPeriod({required SignInProvider signInProvider}) async {
    signInProvider.period = await PeriodService.fetchPeriod(
        departmentId: signInProvider.department!.id,
        jwtToken: signInProvider.auth!.jwtToken);
  }
}
