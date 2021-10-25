import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/models/company/company.dart';
import 'package:office_supply_mobile_master/models/department/department.dart';
import 'package:office_supply_mobile_master/models/role/role.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
import 'package:office_supply_mobile_master/pages/guest/sign_in/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/controllers/google_sign_in_controller.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({Key? key, required this.size}) : super(key: key);
  final Size size;

  @override
  Widget build(BuildContext context) {
    final user =
        Provider.of<GoogleSignInController>(context, listen: false).user;
    final userRole =
        Provider.of<GoogleSignInController>(context, listen: false).userRole;
    final department =
        Provider.of<GoogleSignInController>(context, listen: false).department;
    final company =
        Provider.of<GoogleSignInController>(context, listen: false).company;

    return Stack(
      children: [
        backgroundImage(imagePath + sweetHomePNG),
        backgroundColor(primaryLightColorTransparent),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 52),
            child: searchTextField(),
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
                  accountAvatar(photoUrl: user.avatarUrl),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 6,
                    child: user.companyID != null
                        ? accountInfoInCompany(
                            user: user,
                            userRole: userRole,
                            department: department!,
                            company: company!,
                          )
                        : accountInfo(
                            user: user,
                            userRole: userRole,
                          ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        notificationButton(() {}),
                        const SizedBox(
                          height: 10,
                        ),
                        signOutButton(
                          () {
                            Provider.of<GoogleSignInController>(context,
                                    listen: false)
                                .signOut();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const SignInPage()),
                            );
                          },
                        )
                      ],
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

  accountAvatar({required String photoUrl}) => Material(
        elevation: 5,
        shadowColor: primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        child: CircleAvatar(
          radius: 28,
          backgroundImage: const AssetImage(imagePath + blueAndPinkPNG),
          child: CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(photoUrl),
          ),
        ),
      );

  accountInfo({
    required User user,
    required Role userRole,
  }) {
    String roleNameVietnamese;
    switch (userRole.name) {
      case 'Admin':
        roleNameVietnamese = 'Quản trị viên';
        break;
      case 'Manager':
        roleNameVietnamese = 'Người quản lý';
        break;
      case 'Leader':
        roleNameVietnamese = 'Trưởng phòng';
        break;
      case 'Employee':
        roleNameVietnamese = 'Nhân viên';
        break;
      default:
        roleNameVietnamese = 'Khách';
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //!user name
          Text(
            user.firstname + ' ' + user.lastname,
            style: h6.copyWith(color: primaryLightColor, fontSize: 14),
            textAlign: TextAlign.start,
          ),
          //!user role
          Text(
            '($roleNameVietnamese)',
            style: h6.copyWith(
              color: primaryLightColor,
              fontWeight: FontWeight.w200,
              fontSize: 13,
            ),
            textAlign: TextAlign.start,
          ),
          //!deparment wallet
          Row(
            children: [
              Text(
                '1,642,000₫',
                style: h6.copyWith(
                  color: primaryLightColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                Icons.remove_red_eye,
                color: Colors.yellow.shade800,
                size: 14,
              )
            ],
          ),
        ],
      ),
    );
  }

  accountInfoInCompany({
    required User user,
    required Role userRole,
    required Department department,
    required Company company,
  }) {
    String roleNameVietnamese;
    switch (userRole.name) {
      case 'Admin':
        roleNameVietnamese = 'Quản trị viên';
        break;
      case 'Manager':
        roleNameVietnamese = 'Người quản lý';
        break;
      case 'Leader':
        roleNameVietnamese = 'Trưởng phòng';
        break;
      case 'Employee':
        roleNameVietnamese = 'Nhân viên';
        break;
      default:
        roleNameVietnamese = 'Khách';
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //!user name && role
          RichText(
            text: TextSpan(
              text: user.firstname + ' ' + user.lastname,
              style: h6.copyWith(
                color: primaryLightColor,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: ' ($roleNameVietnamese)',
                  style: h6.copyWith(
                    color: primaryLightColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          //!deparment wallet
          Row(
            children: [
              Text(
                'Phòng: ${department.name} - ',
                style: h6.copyWith(
                  color: primaryLightColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
                textAlign: TextAlign.start,
              ),
              Text(
                '1,642,000₫',
                style: h6.copyWith(
                  color: primaryLightColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                Icons.remove_red_eye,
                color: Colors.yellow.shade800,
                size: 14,
              )
            ],
          ),
          Text(
            'Công ty: ${company.name}',
            style: h6.copyWith(
              color: primaryLightColor,
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
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

  signOutButton(VoidCallback onTap) => InkWell(
        onTap: onTap,
        child: const Icon(
          Icons.logout_outlined,
          color: primaryLightColor,
          size: 15,
        ),
      );

  searchTextField() => SizedBox(
        width: size.width * 5 / 7,
        height: 40,
        child: const Material(
          elevation: 5,
          shadowColor: primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          child: TextField(
            obscureText: false,
            autofocus: false,
            decoration: InputDecoration(
              isCollapsed: true,
              prefixIcon: Icon(
                Icons.search,
                color: primaryColor,
                size: 18,
              ),
              suffixIcon: Icon(
                Icons.list,
                color: primaryColor,
                size: 18,
              ),
              hintText: 'Tìm loại văn phòng phẩm',
              hintStyle: TextStyle(
                fontSize: 10,
                color: lightGrey,
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
          ),
        ),
      );

  backgroundImage(String photoUrl) => Container(
        height: 92,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(photoUrl),
            fit: BoxFit.cover,
          ),
        ),
      );

  backgroundColor(Color color) => Container(
        height: 92,
        decoration: BoxDecoration(
          color: color,
        ),
      );
}
