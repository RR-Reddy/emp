part of 'add_edit_cubit.dart';

@immutable
class AddEditState {
  final EmpNameInput empNameInput;
  final EmpRoleInput empRoleInput;
  final EmpStartDateInput empStartDateInput;
  final EmpEndDateInput empEndDateInput;

  const AddEditState({
    this.empNameInput = const EmpNameInput.pure(),
    this.empRoleInput = const EmpRoleInput.pure(),
    this.empStartDateInput = const EmpStartDateInput.pure(),
    this.empEndDateInput = const EmpEndDateInput.pure(),
  });

  AddEditState copyWith({
    EmpNameInput? empNameInput,
    EmpRoleInput? empRoleInput,
    EmpStartDateInput? empStartDateInput,
    EmpEndDateInput? empEndDateInput,
  }) {
    return AddEditState(
      empNameInput: empNameInput ?? this.empNameInput,
      empRoleInput: empRoleInput ?? this.empRoleInput,
      empStartDateInput: empStartDateInput ?? this.empStartDateInput,
      empEndDateInput: empEndDateInput ?? this.empEndDateInput,
    );
  }
}

class EmpNameInput extends FormzInput<String, String> {
  const EmpNameInput.pure() : super.pure('');

  const EmpNameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  String? validator(String value) {
    return value.isEmpty ? 'should not be empty' : null;
  }
}

class EmpRoleInput extends FormzInput<String?, String> {
  const EmpRoleInput.pure() : super.pure(null);

  const EmpRoleInput.dirty({String? value}) : super.dirty(value);

  @override
  String? validator(String? value) {
    return value==null ? 'should not be empty' : null;
  }
}

class EmpStartDateInput extends FormzInput<DateTime?, String> {
  const EmpStartDateInput.pure() : super.pure(null);

  const EmpStartDateInput.dirty({required DateTime value}) : super.dirty(value);

  @override
  String? validator(DateTime? value) {
    return value == null ? 'should not be empty' : null;
  }
}

class EmpEndDateInput extends FormzInput<DateTime?, String> {
  const EmpEndDateInput.pure() : super.pure(null);

  const EmpEndDateInput.dirty({ DateTime? value}) : super.dirty(value);

  @override
  String? validator(DateTime? value) {
    return value == null ? 'should not be empty' : null;
  }
}
