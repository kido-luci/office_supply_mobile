// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:office_supply_mobile_master/models/department/department.dart';
import 'package:office_supply_mobile_master/services/department.dart';

class DepartmentProvider with ChangeNotifier {
  late List<Department> departments;

  getDepartmentOfCompany({
    required String jwtToken,
    required int userID,
    required bool all,
  }) async {
    departments = (await DepartmentAPI.getDepartments(
        userID: userID, jwtToken: jwtToken, all: all))!;
    notifyListeners();
  }
}
