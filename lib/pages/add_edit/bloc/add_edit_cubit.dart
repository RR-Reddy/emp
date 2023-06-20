import 'package:bloc/bloc.dart';
import 'package:emp/extensions/index.dart';
import 'package:emp/models/employee.dart';
import 'package:emp/pages/add_edit/widgets/index.dart';
import 'package:emp/pages/home/bloc/emp_list_cubit.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';

part 'add_edit_state.dart';

class AddEditCubit extends Cubit<AddEditState> {
  late final TextEditingController empNameCtrl;
  final empNameFocusNode = FocusNode(debugLabel: 'empName');
  final empRoleFocusNode = FocusNode(debugLabel: 'empRole');
  final empStartDateFocusNode = FocusNode(debugLabel: 'empStartDate');
  final empEndFocusNode = FocusNode(debugLabel: 'empEndDate');
  final Employee? editEmp;
  final EmpListCubit empListCubit;

  bool get isEditMode => editEmp != null;

  AddEditCubit({
    this.editEmp,
    required this.empListCubit,
  }) : super(
          const AddEditState().copyWith(
            empStartDateInput: EmpStartDateInput.dirty(value: DateTime.now()),
          ),
        ) {
    empNameCtrl = TextEditingController();
    if (isEditMode) {
      _setEditData();
    }
  }

  void _setEditData() {
    empNameCtrl.text = editEmp!.name;
    final newState = state.copyWith(
      empNameInput: EmpNameInput.dirty(value: editEmp!.name),
      empRoleInput: EmpRoleInput.dirty(value: editEmp!.role),
      empStartDateInput: EmpStartDateInput.dirty(value: editEmp!.startDate),
      empEndDateInput: EmpEndDateInput.dirty(value: editEmp?.endDate),
    );
    emit(newState);
  }

  void updateEmpName(String value) {
    emit(state.copyWith(empNameInput: EmpNameInput.dirty(value: value)));
  }

  Employee empFromState() {
    return Employee(
      id: isEditMode ? editEmp!.id : DateTime.now().millisecondsSinceEpoch,
      name: state.empNameInput.value,
      role: state.empRoleInput.value ?? '',
      endDate: state.empEndDateInput.value,
      startDate: state.empStartDateInput.value!,
    );
  }

  void selectAndUpdateRole(BuildContext context) async {
    empNameFocusNode.unfocus();
    final selectedRole = await EmpRoleBottomSheet.show(context);
    empRoleFocusNode.unfocus();
    emit(state.copyWith(empRoleInput: EmpRoleInput.dirty(value: selectedRole)));
  }

  void selectAndUpdateStartDate(BuildContext context) async {
    empNameFocusNode.unfocus();
    final selectedDate = await EmpDateDialog.show(
      context: context,
      firstDate: DateTime.now().add(
        const Duration(days: -45),
      ),
      lastDate: DateTime.now().add(
        const Duration(days: 45),
      ),
      initialSelectedDate: DateTime.now(),
      isStartDate: true,
    );
    empStartDateFocusNode.unfocus();
    if (selectedDate == null) {
      return;
    }
    emit(
      state.copyWith(
          empStartDateInput: EmpStartDateInput.dirty(value: selectedDate)),
    );
  }

  void selectAndUpdateEndDate(BuildContext context) async {
    empNameFocusNode.unfocus();
    var firstDate = state.empStartDateInput.value ?? DateTime.now();

    final endDate = await EmpDateDialog.show(
      context: context,
      firstDate: firstDate,
      lastDate: firstDate.add(
        const Duration(days: 45),
      ),
      initialSelectedDate: firstDate,
      isStartDate: false,
    );
    empEndFocusNode.unfocus();
    emit(
      state.copyWith(empEndDateInput: EmpEndDateInput.dirty(value: endDate)),
    );
  }

  void addOrEditEmployee(BuildContext context) {
    context.unfoucs();
    isEditMode
        ? empListCubit.editEmployee(empFromState())
        : empListCubit.addEmployee(empFromState());
    context.nav.pop();
  }

  @override
  Future<void> close() async {
    empNameCtrl.dispose();
    empNameFocusNode.dispose();
    empRoleFocusNode.dispose();
    empStartDateFocusNode.dispose();
    empEndFocusNode.dispose();
    return super.close();
  }
}
