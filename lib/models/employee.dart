import 'package:intl/intl.dart';

class Employee {
  final int id;
  final String name;
  final String role;
  final DateTime startDate;
  final DateTime? endDate;

  const Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.startDate,
    this.endDate,
  });


  @override
  String toString() {
    return 'Employee{id: $id, name: $name, role: $role, startDate: $startDate, endDate: $endDate}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role':role,
      'startDate': DateFormat('dd-MM-yyyy').format(startDate),
      'endDate':
          endDate == null ? null : DateFormat('dd-MM-yyyy').format(endDate!),
    };
  }

  factory Employee.fromJson(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as int,
      name: map['name'] as String,
      role: map['role'] as String,
      startDate: DateFormat('dd-MM-yyyy').parse(map['startDate']),
      endDate: map['endDate'] == null
          ? null
          : DateFormat('dd-MM-yyyy').parse(map['endDate']),
    );
  }
}
