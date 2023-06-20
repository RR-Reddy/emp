import 'dart:convert';

import 'package:emp/models/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences prefs;
  static const _dataKey = 'empList';

  StorageService(this.prefs);

  void saveEmployeeList(List<Employee> list) {
    String json = jsonEncode(list.map((i) => i.toJson()).toList()).toString();
    prefs.setString(_dataKey, json);
  }

  List<Employee> readEmployeeList() {
    final data = prefs.getString(_dataKey);
    if (data == null) {
      return [];
    }
    Iterable l = json.decode(data);
    return List<Employee>.from(l.map((model) => Employee.fromJson(model)));
  }
}
