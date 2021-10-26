// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/controllers/google_sign_in_controller.dart';
import 'package:office_supply_mobile_master/models/period/period.dart';
import 'package:office_supply_mobile_master/services/periodService.dart';
import 'package:provider/provider.dart';

class ListPeriod extends StatelessWidget {
  const ListPeriod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfo = context.watch<GoogleSignInController>().user;
    final jwtToken = context.watch<GoogleSignInController>().auth;

    return Scaffold(
      appBar: AppBar(
        title: Text('Periods'),
      ),
      backgroundColor: Colors.grey[350],
      body: FutureBuilder<dynamic>(
        future: PeriodService.getPeriodOfCompany(
            companyId: userInfo.companyID, jwtToken: jwtToken!.jwtToken),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: createPeriodList(snapshot.data),
            );
          } else {
            return Center(child: Text('No Data'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/period_form');
        },
      ),
    );
  }

  List<Widget> createPeriodList(List<Period> data) {
    List<Widget> list = List.empty(growable: true);

    for (var p in data) {
      var item = InkWell(
        onTap: () {
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
                      Icon(Icons.account_circle_rounded),
                      Text(
                        'Name:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        p.name,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule_outlined),
                      Text(
                        'From Time:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        p.fromTime.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule_outlined),
                      Text(
                        'To Time:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        p.toTime.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money_outlined),
                      Text(
                        'Quota:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        p.quota.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money_outlined),
                      Text(
                        'Remaining Quota',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        p.remainingQuota.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
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
}
