import 'package:emp/extensions/index.dart';
import 'package:emp/models/employee.dart';
import 'package:emp/pages/add_edit/bloc/add_edit_cubit.dart';
import 'package:emp/pages/add_edit/widgets/index.dart';
import 'package:emp/pages/home/bloc/emp_list_cubit.dart';
import 'package:emp/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditPage extends StatelessWidget {
  const AddEditPage({Key? key, this.employee}) : super(key: key);
  static const routeName = '/add-edit';
  final Employee? employee;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddEditCubit(
        editEmp: employee,
        empListCubit: context.read<EmpListCubit>(),
      ),
      child: GestureDetector(
        onTap: () => context.unfoucs(),
        child: const Scaffold(
          appBar: AppbarWidget(),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: _BodyWidget(),
          ),
        ),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EmpNameWidget(),
        const SizedBox(height: 12),
        const EmpRoleWidget(),
        const SizedBox(height: 12),
        Row(
          children: [
            const Expanded(
              child: _StartDateWidget(),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Image.asset(
                'assets/ic_arrow.png',
                width: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Expanded(child: _EndDateWidget()),
          ],
        ),
        const SizedBox(height: 12),
        const Spacer(),
        const CtaActionWidget(),
      ],
    );
  }
}

class EmpNameWidget extends StatelessWidget {
  const EmpNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddEditCubit>();
    return BlocBuilder<AddEditCubit, AddEditState>(
      buildWhen: (previous, current) =>
          previous.empNameInput.value != current.empNameInput.value,
      builder: (_, state) {
        return InputTextWidget(
          controller: bloc.empNameCtrl,
          focusNode: bloc.empNameFocusNode,
          autofocus: !bloc.isEditMode,
          onChanged: (value) => bloc.updateEmpName(value),
          prefixIcon: Image.asset('assets/ic_emp_name.png'),
        );
      },
    );
  }
}

class EmpRoleWidget extends StatelessWidget {
  const EmpRoleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddEditCubit>();
    return BlocBuilder<AddEditCubit, AddEditState>(
      buildWhen: (previous, current) =>
          previous.empRoleInput.value != current.empRoleInput.value,
      builder: (_, state) {
        return InputTextWidget(
          readOnly: true,
          key: Key('1${state.empRoleInput.value}'),
          initialValue: state.empRoleInput.value,
          focusNode: bloc.empRoleFocusNode,
          onTap: () =>
              context.read<AddEditCubit>().selectAndUpdateRole(context),
          prefixIcon: Image.asset('assets/ic_emp_role.png'),
          suffixIcon: Image.asset('assets/ic_dropdown.png'),
        );
      },
    );
  }
}

class _StartDateWidget extends StatelessWidget {
  const _StartDateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddEditCubit>();
    return BlocBuilder<AddEditCubit, AddEditState>(
      buildWhen: (previous, current) =>
          previous.empStartDateInput.value != current.empStartDateInput.value,
      builder: (_, state) {
        final selectedDate = state.empStartDateInput.value?.toUserReadFormat;

        final isToday = state.empStartDateInput.value?.isToday ?? false;
        return InputTextWidget(
          readOnly: true,
          key: Key('3$selectedDate'),
          initialValue: isToday ? 'Today' : selectedDate,
          focusNode: bloc.empStartDateFocusNode,
          prefixIcon: Image.asset('assets/ic_date.png'),
          onTap: () =>
              context.read<AddEditCubit>().selectAndUpdateStartDate(context),
        );
      },
    );
  }
}

class _EndDateWidget extends StatelessWidget {
  const _EndDateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddEditCubit>();
    return BlocBuilder<AddEditCubit, AddEditState>(
      buildWhen: (previous, current) =>
          previous.empEndDateInput.value != current.empEndDateInput.value,
      builder: (_, state) {
        final selectedDate = state.empEndDateInput.value?.toUserReadFormat;

        return InputTextWidget(
          readOnly: true,
          key: Key('4$selectedDate'),
          initialValue: selectedDate ?? 'No Date',
          focusNode: bloc.empEndFocusNode,
          onTap: () =>
              context.read<AddEditCubit>().selectAndUpdateEndDate(context),
          prefixIcon: Image.asset('assets/ic_date.png'),
        );
      },
    );
  }
}
