// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/manager/period/widget/top_navigation_bar.dart';

class PeriodForm extends StatefulWidget {
  const PeriodForm({Key? key}) : super(key: key);

  @override
  _PeriodFormState createState() => _PeriodFormState();
}

class _PeriodFormState extends State<PeriodForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Period Form'),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10,
          top: 20,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 150,
              child: TopNavigationBar(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectDate(context, fromDate, true);
                    setState(() {});
                  },
                  child: Text(
                      '${fromDate.month}/${fromDate.day}/${fromDate.year}'),
                )
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectDate(context, toDate, false);
                    setState(() {});
                  },
                  child: Text('${toDate.month}/${toDate.day}/${toDate.year}'),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quota',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Quota'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.grey[350],
    );
  }

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now().add(const Duration(days: 1));

  selectDate(BuildContext context, DateTime initDate, bool from) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    print(picked);
    if (picked != null) {
      print('ok');
      setState(() {
        if (from) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
      print('from: ${fromDate.toString()}');
      print('from: ${toDate.toString()}');
    }
  }
}
