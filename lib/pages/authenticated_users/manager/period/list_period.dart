// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/models/department/department.dart';
import 'package:office_supply_mobile_master/models/period/period.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/manager/managerBottomNav.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/manager/provider/departmentProvide.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/period.dart';
import 'package:provider/provider.dart';

class ListPeriod extends StatelessWidget {
  const ListPeriod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfo = context.watch<SignInProvider>().user;
    final jwtToken = context.watch<SignInProvider>().auth;

    context.read<DepartmentProvider>().getDepartmentOfCompany(
        userID: userInfo!.id, jwtToken: jwtToken!.jwtToken, all: true);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Periods'),
      // ),
      backgroundColor: Colors.grey[350],
      body: FutureBuilder<dynamic>(
        future: PeriodService.getPeriodOfCompany(
            user: userInfo, jwtToken: jwtToken.jwtToken),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: createPeriodList(context, snapshot.data),
            );
          } else {
            return Center(child: Text('No Data'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/period_form');
        },
      ),
      bottomNavigationBar: ManagerBottomNav(),
    );
  }

  List<Widget> createPeriodList(BuildContext context, List<Period> data) {
    List<Widget> list = List.empty(growable: true);

    for (var p in data) {
      var item = InkWell(
        onTap: () {
          // ignore: avoid_print
          print(p.id);
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('ID: ' + p.id.toString()),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.account_circle_rounded),
                      ),
                      Text(
                        'Name:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          p.name,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.business),
                      ),
                      Text(
                        'Department:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          getDepartmentName(context, p.departmentID)!.name,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.schedule_outlined),
                      ),
                      Text(
                        'From Time:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '${p.fromTime.year}-${p.fromTime.month}-${p.fromTime.day}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.schedule_outlined),
                      ),
                      Text(
                        'To Time:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '${p.toTime.year}-${p.toTime.month}-${p.toTime.day}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.attach_money_outlined),
                      ),
                      Text(
                        'Quota:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '${p.quota} VNĐ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.attach_money_outlined),
                      ),
                      Text(
                        'Remaining Quota:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '${p.remainingQuota} VNĐ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.timer_off),
                      ),
                      Text(
                        'Expired:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '${p.isExpired}',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
      list.add(item);
    }
    return list;
  }

  Department? getDepartmentName(BuildContext context, int departmentId) {
    final departments = context.watch<DepartmentProvider>().departments;

    for (var item in departments) {
      if (item.id == departmentId) {
        return item;
      }
    }
    return null;
  }
}
