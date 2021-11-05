// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/models/department/department.dart';
import 'package:office_supply_mobile_master/models/period/periodPayload.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/manager/provider/departmentProvide.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/period.dart';
import 'package:provider/provider.dart';

class PeriodForm extends StatefulWidget {
  const PeriodForm({Key? key}) : super(key: key);

  @override
  _PeriodFormState createState() => _PeriodFormState();
}

class _PeriodFormState extends State<PeriodForm> {
  dynamic selectedValue;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtQuota = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInProvider>(context, listen: false);
    final departments = context.watch<DepartmentProvider>().departments;
    final jwtToken = signInProvider.auth!;
    final company = signInProvider.company;

    return Scaffold(
      appBar: AppBar(
        title: Text('Period Form'),
        backgroundColor: Colors.indigo[400],
      ),
      backgroundColor: Colors.indigo[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10,
            top: 20,
          ),
          child: Column(
            children: [
              ////////////////////////////////////////// name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  createInfo('Wallet: ${company!.wallet} VNĐ'),
                  SizedBox(
                    height: 5,
                  ),
                  // name
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                      ),
                      child: TextFormField(
                        controller: txtName,
                        decoration: InputDecoration(
                          labelText: "Name",
                          hintText: "Enter name",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ////////////////////////////////////////// department
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Department',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: DropdownButton(
                        hint: Text('Choose department'),
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        value: selectedValue,
                        onChanged: (newValue) {
                          setState(() {
                            // print(newValue);
                            // var dep = getDepartmentName(
                            //     departments, int.parse(newValue.toString()));
                            // print(dep!.name);
                            // selectedValue = dep.name;
                            selectedValue = newValue;
                          });
                        },
                        items: departments.map((d) {
                          // print('${d.id} - ${d.name}');
                          return DropdownMenuItem(
                            value: d.id,
                            child: Text(d.name),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ////////////////////////////////////////// chose time
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From Time',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            selectDate(context, fromDate, true);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFF5F6F9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              minimumSize: Size(150, 40)),
                          child: Text(
                            '${fromDate.month}/${fromDate.day}/${fromDate.year}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To Time',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFF5F6F9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              minimumSize: Size(150, 40)),
                          onPressed: () {
                            selectDate(context, toDate, false);
                          },
                          child: Text(
                            '${toDate.month}/${toDate.day}/${toDate.year}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ////////////////////////////////////////// quota
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                  ),
                  child: TextFormField(
                    controller: txtQuota,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Quota",
                      hintText: "Enter quota",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 20),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              ////////////////// button
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        var periodPayload = PeriodPayload(
                          name: txtName.text,
                          departmentID: selectedValue,
                          fromTime: fromDate,
                          toTime: toDate,
                          quota: double.parse(txtQuota.text),
                        );
                        var result = await createPeriod(
                            periodPayload, jwtToken.jwtToken);
                        if (result!['isSuccess']) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Create Result'),
                                content: Text('Create success'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed('/list_period');
                                    },
                                    child: Text('Ok'),
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Create Result'),
                                content:
                                    Text(result['messageDetail'].toString()),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Ok'),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      },
                      icon: Icon(Icons.add),
                      label: Text('Create'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        textStyle: TextStyle(fontSize: 18),
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 50),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.dangerous_outlined),
                      label: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        textStyle: TextStyle(fontSize: 18),
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 50),
                        primary: Colors.red[400],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
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

    if (picked != null) {
      setState(() {
        if (from) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  Department? getDepartmentName(
      List<Department> departments, int departmentId) {
    for (var item in departments) {
      if (item.id == departmentId) {
        return item;
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> createPeriod(
      PeriodPayload periodPayload, String jwtToken) async {
    var resData = await PeriodService.createPeriod(
        jwtToken: jwtToken, periodPayload: periodPayload);

    return resData;
  }

  Widget createInfo(String text) {
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
}
