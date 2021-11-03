// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:office_supply_mobile_master/models/period/period.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
import 'package:office_supply_mobile_master/services/period.dart';

class PeriodProvider with ChangeNotifier {
  late List<Period> periods;
  late Period periodOfDepartment;

  getPeriodsOfCompany(User user, String jwtToken) async {
    final data = await PeriodService.getPeriodOfCompany(
        user: user, jwtToken: jwtToken);
    periods = data!;
    notifyListeners();
  }

  getPeriodOfDepartment(String jwtToken, int departmentId) async {
    final data = await PeriodService.fetchPeriod(jwtToken: jwtToken, departmentId: departmentId);
    periodOfDepartment = data!;
    notifyListeners();
  }
}
