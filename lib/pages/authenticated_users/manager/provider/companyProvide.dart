// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:office_supply_mobile_master/models/company/company.dart';
import 'package:office_supply_mobile_master/services/company.dart';

class CompanyProvider with ChangeNotifier {
  late Company company;

  getCompanyById({
    required int id,
    required String jwtToken,
  }) async {
    company = await CompanyService.fetchCompany(id: id, jwtToken: jwtToken);
    notifyListeners();
  }
}
