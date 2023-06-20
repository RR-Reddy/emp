import 'package:bloc/bloc.dart';
import 'package:emp/models/employee.dart';
import 'package:emp/service/storage_service.dart';
import 'package:flutter/material.dart';

part 'emp_list_state.dart';

class EmpListCubit extends Cubit<EmpListState> {
  final StorageService service;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  EmpListCubit({
    required this.service,
    required this.scaffoldMessengerKey,
  }) : super(
          EmpListState(
            list: const [],
            updatedTimeStamp: DateTime.now(),
            isLoading: true,
          ),
        ) {
    _readData();
  }

  void _readData() async {
    final list = service.readEmployeeList();
    final newState = state.copyWith(
      isLoading: false,
      list: list,
      updatedTimeStamp: DateTime.now(),
    );
    emit(newState);
  }

  void _saveData() {
    service.saveEmployeeList(state.list);
  }

  void addEmployee(Employee employee) {
    final newState = state.copyWith(
      list: [...state.list, employee],
      updatedTimeStamp: DateTime.now(),
    );
    emit(newState);
    _saveData();
  }

  void editEmployee(Employee e) {
    final list = [...state.list]..removeWhere((emp) => emp.id == e.id);
    list.add(e);
    final newState = state.copyWith(
      list: list,
      updatedTimeStamp: DateTime.now(),
    );
    emit(newState);
    _saveData();
  }

  void deleteEmployee(Employee e) {
    final list = [...state.list]..removeWhere((emp) => emp.id == e.id);
    final newState = state.copyWith(
      list: list,
      updatedTimeStamp: DateTime.now(),
    );
    emit(newState);
    _saveData();
    _showUndoSnackBar(e);
  }

  void _showUndoSnackBar(Employee employee) {
    final snackBar = SnackBar(
      content: const Text('Employee data has been deleted'),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () => addEmployee(employee),
      ),
    );

    scaffoldMessengerKey.currentState?.clearSnackBars();
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
