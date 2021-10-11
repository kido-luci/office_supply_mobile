import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/widgets/circle_icon_button.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar(
      {Key? key, required this.size, required this.onTapBack})
      : super(key: key);
  final Size size;
  final VoidCallback onTapBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundImage(imagePath + sweetHomePNG),
        backgroundColor(primaryLightColorTransparent),
        CircleIconButton(
          onTap: () {
            Navigator.of(context).pop();
            onTapBack.call();
          },
          margin: const EdgeInsets.only(top: 10, left: 10),
          iconData: Icons.arrow_back_ios,
          size: 30,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'Thông tin sản phẩm',
            style: h5.copyWith(color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [],
                    ),
                  ),
                ],
              ),
            ],
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
        height: 50,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(photoUrl),
            fit: BoxFit.cover,
          ),
        ),
      );

  backgroundColor(Color color) => Container(
        height: 50,
        decoration: BoxDecoration(
          color: color,
        ),
      );
}
