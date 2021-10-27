import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/models/period/period.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/period.dart';
import 'package:provider/provider.dart';

class ListPeriod extends StatelessWidget {
  const ListPeriod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInProvider signInProvider =
        Provider.of<SignInProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Periods'),
      ),
      backgroundColor: Colors.grey[350],
      body: FutureBuilder<dynamic>(
        future: PeriodService.getPeriodOfCompany(
          companyId: signInProvider.user!.companyID,
          jwtToken: signInProvider.auth!.jwtToken,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: createPeriodList(snapshot.data),
            );
          } else {
            return const Center(child: Text('No Data'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
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
                      const Icon(Icons.account_circle_rounded),
                      const Text(
                        'Name:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        p.name,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.schedule_outlined),
                      const Text(
                        'From Time:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        p.fromTime.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.schedule_outlined),
                      const Text(
                        'To Time:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        p.toTime.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.attach_money_outlined),
                      const Text(
                        'Quota:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        p.quota.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.attach_money_outlined),
                      const Text(
                        'Remaining Quota',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        p.remainingQuota.toString(),
                        style: const TextStyle(fontSize: 18),
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
