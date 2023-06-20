import 'package:emp/pages/add_edit/bloc/add_edit_cubit.dart';
import 'package:emp/pages/home/bloc/emp_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isEditMode = context.read<AddEditCubit>().isEditMode;
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('${isEditMode ? 'Edit' : 'Add'} Employee Details'),
      actions: [
        if (isEditMode) ...{
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () {
                context.read<EmpListCubit>().deleteEmployee(
                    context.read<AddEditCubit>().editEmp!);
                Navigator.of(context).pop();
              },
              child: Image.asset(
                'assets/ic_delete.png',
                width: 16,
              ),
            ),
          ),
        }
      ],
    );
  }
}
