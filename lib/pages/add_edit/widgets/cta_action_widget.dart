import 'package:emp/extensions/index.dart';
import 'package:emp/pages/add_edit/bloc/add_edit_cubit.dart';
import 'package:emp/theme/app_colors.dart';
import 'package:emp/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CtaActionWidget extends StatelessWidget {
  const CtaActionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.ctaBorder,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          const Spacer(),
          CtaButtonWidget(
            onTap: () => context.nav.pop(),
            title: 'Cancel',
            isSecondary: true,
          ),
          const SizedBox(width: 8),
          CtaButtonWidget(
            onTap: () =>
                context.read<AddEditCubit>().addOrEditEmployee(context),
            title: 'Save',
          ),
        ],
      ),
    );
  }
}
