import 'package:emp/extensions/index.dart';
import 'package:emp/pages/add_edit/bloc/add_edit_cubit.dart';
import 'package:emp/pages/add_edit/bloc/emp_date_cubit.dart';
import 'package:emp/theme/app_colors.dart';
import 'package:emp/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmpDateDialog {
  static Future<DateTime?> show({
    required BuildContext context,
    bool isStartDate = false,
    required DateTime firstDate,
    required DateTime lastDate,
    required DateTime initialSelectedDate,
  }) {
    final addEditBloc = context.read<AddEditCubit>();
    return showDialog<DateTime?>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => EmpDateCubit(
                  isStartDate: isStartDate,
                  initialSelectedDate: initialSelectedDate,
                  firstDate: firstDate,
                  lastDate: lastDate,
                ),
              ),
              BlocProvider.value(value: addEditBloc),
            ],
            child: const _BodyWidget(),
          ),
        );
      },
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final empDateCubit = context.read<EmpDateCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          empDateCubit.isStartDate
              ? const _HeaderStartDateWidget()
              : const _HeaderEndDateWidget(),
          const SizedBox(height: 16),
          BlocBuilder<EmpDateCubit, DateTime?>(
            builder: (context, state) {
              return DatePickWidget(
                firstDate: empDateCubit.firstDate,
                lastDate: empDateCubit.lastDate,
                selectedDate: state ?? DateTime.now(),
                onChanged: (dateTime) =>
                    context.read<EmpDateCubit>().updateDate(dateTime),
              );
            },
          ),
          const SizedBox(height: 16),
          const _FooterWidget(),
        ],
      ),
    );
  }
}

class _HeaderStartDateWidget extends StatelessWidget {
  const _HeaderStartDateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: BlocBuilder<EmpDateCubit, DateTime?>(
                builder: (context, state) {
                  return _DayTileWidget(
                    name: 'Today',
                    isSelected: state?.isToday ?? false,
                    onTap: () =>
                        context.read<EmpDateCubit>().updateDate(DateTime.now()),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: BlocBuilder<EmpDateCubit, DateTime?>(
                builder: (context, state) {
                  return _DayTileWidget(
                    name: 'Next Monday',
                    isSelected: state?.isNextWeekDay(1) ?? false,
                    onTap: () => context
                        .read<EmpDateCubit>()
                        .updateDate(DateTime.now().nextWeekDay(1)),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: BlocBuilder<EmpDateCubit, DateTime?>(
                builder: (context, state) {
                  return _DayTileWidget(
                    name: 'Next Tuesday',
                    isSelected: state?.isNextWeekDay(2) ?? false,
                    onTap: () => context
                        .read<EmpDateCubit>()
                        .updateDate(DateTime.now().nextWeekDay(2)),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: BlocBuilder<EmpDateCubit, DateTime?>(
                builder: (context, state) {
                  return _DayTileWidget(
                    name: 'After 1 week',
                    isSelected: state?.isAfterWeek ?? false,
                    onTap: () => context
                        .read<EmpDateCubit>()
                        .updateDate(DateTime.now().afterOneWeek),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeaderEndDateWidget extends StatelessWidget {
  const _HeaderEndDateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<EmpDateCubit, DateTime?>(
            builder: (context, state) {
              return _DayTileWidget(
                name: 'No Date',
                isSelected: state == null,
                onTap: () => context.read<EmpDateCubit>().updateDate(null),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: BlocBuilder<EmpDateCubit, DateTime?>(
            builder: (context, state) {
              return _DayTileWidget(
                name: 'Today',
                isSelected: state?.isToday ?? false,
                onTap: () =>
                    context.read<EmpDateCubit>().updateDate(DateTime.now()),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FooterWidget extends StatelessWidget {
  const _FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/ic_date.png',
          width: 20,
        ),
        const SizedBox(width: 8),
        BlocBuilder<EmpDateCubit, DateTime?>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return Text(state == null ? 'No date' : state.toUserReadFormat);
          },
        ),
        const Spacer(),
        CtaButtonWidget(
          onTap: () => Navigator.of(context).pop(),
          title: 'Cancel',
          isSecondary: true,
        ),
        const SizedBox(width: 8),
        CtaButtonWidget(
          onTap: () =>
              Navigator.of(context).pop(context.read<EmpDateCubit>().state),
          title: 'Save',
        ),
      ],
    );
  }
}

class _DayTileWidget extends StatelessWidget {
  const _DayTileWidget({
    Key? key,
    required this.name,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);
  final String name;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.dateSelected : AppColors.dateUnSelected,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? AppColors.dateUnSelected
                    : AppColors.dateSelected,
              ),
        ),
      ),
    );
  }
}
