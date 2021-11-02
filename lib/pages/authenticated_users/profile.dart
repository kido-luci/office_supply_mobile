// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:office_supply_mobile_master/models/user/userUpdatePayload.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/manager/managerBottomNav.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/user.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController txtFirstname = TextEditingController();
  TextEditingController txtLastname = TextEditingController();
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtAddress = TextEditingController();

  late DateTime dateSelect = DateTime.now().add(Duration(days: 1));
  int gender = 2;

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var userInfo = context.watch<SignInProvider>().user!;
    var jwtToken = context.watch<SignInProvider>().auth!;
    var company = context.watch<SignInProvider>().company!;
    var department = context.watch<SignInProvider>().department!;
    // var role = context.watch<SignInProvider>().userRole;

    // print(userInfo.toString());

    txtFirstname.text =
        txtFirstname.text.isEmpty ? userInfo.firstname : txtFirstname.text;
    txtLastname.text =
        txtLastname.text.isEmpty ? userInfo.lastname : txtLastname.text;
    if (txtPhoneNumber.text.isEmpty) {
      txtPhoneNumber.text = userInfo.phoneNumber ?? '';
    }
    //  = txtPhoneNumber.text.isEmpty? userInfo.phoneNumber ?? '';
    if (txtAddress.text.isEmpty) {
      txtAddress.text = userInfo.address ?? '';
    }
    // txtAddress.text = userInfo.address ?? '';

    if (gender == 2) {
      if (userInfo.isMale != null) {
        // print(userInfo.isMale);
        bool isMale = userInfo.isMale ?? false;
        gender = isMale ? 1 : 0;
      }
    }

    if (dateSelect.isAfter(DateTime.now())) {
      // print(userInfo.dateOfBirth);
      dateSelect =
          userInfo.dateOfBirth ?? DateTime.now().add(Duration(days: 1));
    }

    // print(dateSelect);

    return Scaffold(
      bottomNavigationBar: ManagerBottomNav(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    // overflow: Overflow.visible,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(userInfo.avatarUrl),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // company
            createUserInfo('Company: ${company.name}'),
            // department
            createUserInfo('Department: ${department.name}'),
            // role
            createUserInfo('Role: ${userInfo.roleName}'),
            // first name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                ),
                child: TextFormField(
                  controller: txtFirstname,
                  decoration: InputDecoration(
                    labelText: "First Name",
                    hintText: "Enter your first name",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 20),
                    ),
                  ),
                ),
              ),
            ),
            // last name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                ),
                child: TextFormField(
                  controller: txtLastname,
                  decoration: InputDecoration(
                    labelText: "Last Name",
                    hintText: "Enter your last name",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 20),
                    ),
                  ),
                ),
              ),
            ),
            // gender
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFF5F6F9),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // radio button 1
                          Row(
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = int.parse(value.toString());
                                    });
                                  }),
                              SizedBox(
                                width: 1,
                              ),
                              Text('Male'),
                            ],
                          ),

                          // radio button 2
                          Row(
                            children: [
                              Radio(
                                  value: 0,
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = int.parse(value.toString());
                                    });
                                  }),
                              SizedBox(
                                width: 1,
                              ),
                              Text('Female'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // day of birth
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Day of birth',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      selectDate(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF5F6F9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    ),
                    child: Text(
                      dateSelect.isAfter(DateTime.now())
                          ? '--/--/----'
                          : '${dateSelect.month}/${dateSelect.day}/${dateSelect.year}',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            // phone number
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                ),
                child: TextFormField(
                  controller: txtPhoneNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    hintText: "Enter your phone number",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 20),
                    ),
                  ),
                ),
              ),
            ),
            // address
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                ),
                child: TextFormField(
                  controller: txtAddress,
                  decoration: InputDecoration(
                    labelText: "Address",
                    hintText: "Enter your address",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    var result = await updateProfile(
                        context, userInfo.id, jwtToken.jwtToken);
                    if (result) {
                      setState(() {});
                      Fluttertoast.showToast(
                          msg: 'Update profile success',
                          fontSize: 18,
                          gravity: ToastGravity.CENTER);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                  ),
                  child: Text('Update'),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget createUserInfo(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xFFF5F6F9),
        onPressed: () {},
        child: Row(
          children: [
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateSelect,
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        dateSelect = picked;
      });
    }
  }

  Future<bool> updateProfile(
      BuildContext context, int userId, String jwtToken) async {
    var firstName = txtFirstname.text;
    var lastName = txtLastname.text;
    var phoneNumber = txtPhoneNumber.text;
    var address = txtAddress.text;
    var dayOfBirth = dateSelect.isAfter(DateTime.now()) ? null : dateSelect;
    bool? isMale = null;

    if (gender == 1) {
      isMale = true;
    } else if (gender == 0) {
      isMale = false;
    }

    UserUpdatePayload userUpdatePayload = UserUpdatePayload(
        firstname: firstName,
        lastname: lastName,
        dateOfBirth: dayOfBirth,
        isMale: isMale,
        phoneNumber: phoneNumber,
        address: address);

    var result = await UserService.updateUserInfo(
        userId: userId, jwtToken: jwtToken, userPayload: userUpdatePayload);

    if (result!) {
      context.read<SignInProvider>().getUserInfo();
    }
    return result;
  }
}
