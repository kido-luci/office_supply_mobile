import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';

class UserInDepartment extends StatelessWidget {
  final User user;

  const UserInDepartment({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset.zero,
              blurRadius: 3,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(20)),
              child: Image.network(
                user.avatarUrl ==
                        'https://lh3.googleusercontent.com/a-/AOh14Gi8s7mNuBKPiom7icuN2R1FyqUgPM-xJjLzkU3H=s96-c'
                    ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR04V7fXiUf6xb8OwOHZmqL283XrhQw1jWXLLPAUnHY4Tvehs_Vp53jBRhie0cQ5pjIKYE&usqp=CAU'
                    : user.avatarUrl!,
                fit: BoxFit.cover,
                height: 60,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              '#' + user.id.toString(),
              style: h5.copyWith(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: primaryColor),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '${user.firstname} ${user.lastname} ',
              style: h5.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              user.isMale == null || user.isMale! ? '(Nam)' : '(Nữ)',
              style: h6.copyWith(
                fontStyle: FontStyle.italic,
                color: lightGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
