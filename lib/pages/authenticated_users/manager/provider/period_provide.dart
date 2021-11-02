// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:office_supply_mobile_master/models/period/period.dart';
import 'package:office_supply_mobile_master/models/user/user.dart';
import 'package:office_supply_mobile_master/services/period.dart';

class PeriodProvider with ChangeNotifier {
  late List<Period> periods;

  getPeriodsOfCompany(User user, String jwtToken) async {
    final data = await PeriodService.getPeriodOfCompany(
        user: user, jwtToken: jwtToken);
    periods = data!;
    notifyListeners();
  }
}
