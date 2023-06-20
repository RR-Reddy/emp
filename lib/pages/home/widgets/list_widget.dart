import 'package:emp/extensions/index.dart';
import 'package:emp/pages/home/bloc/emp_list_cubit.dart';
import 'package:emp/models/employee.dart';
import 'package:emp/pages/add_edit/add_edit_page.dart';
import 'package:emp/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmpListCubit, EmpListState>(
      builder: (context, state) {
        final currentEmpList =
            state.list.where((item) => item.endDate == null).toList();
        final previousEmpList =
            state.list.where((item) => item.endDate != null).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentEmpList.isNotEmpty) ...{
              Expanded(
                child: _EmpSection(
                  list: currentEmpList,
                  title: 'Current employees',
                ),
              ),
            },
            if (previousEmpList.isNotEmpty) ...{
              Expanded(
                child: _EmpSection(
                  list: previousEmpList,
                  title: 'Previous employees',
                ),
              ),
            },
          ],
        );
      },
    );
  }
}

class _EmpSection extends StatelessWidget {
  const _EmpSection({Key? key, required this.list, required this.title})
      : super(key: key);
  final List<Employee> list;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TitleWidget(title: title),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) => _TileItemWidget(employee: list[index]),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: list.length,
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.darkBg,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

class _TileItemWidget extends StatelessWidget {
  const _TileItemWidget({Key? key, required this.employee}) : super(key: key);
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd MMM, yyyy');
    final dateDuration = employee.endDate == null
        ? 'From ${formatter.format(employee.startDate)}'
        : '${formatter.format(employee.startDate)} - ${formatter.format(employee.endDate!)}';

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (_) =>
                context.read<EmpListCubit>().deleteEmployee(employee),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            child: Image.asset(
              'assets/ic_delete.png',
              width: 18,
            ),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => context.nav.pushNamed(
          AddEditPage.routeName,
          arguments: employee,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                employee.role,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.subTitle,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                dateDuration,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.subTitle,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
