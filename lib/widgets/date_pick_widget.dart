import 'package:emp/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;

class DatePickWidget extends StatelessWidget {
  const DatePickWidget({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    required this.selectedDate,
    required this.onChanged,
  }) : super(key: key);

  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime selectedDate;
  final Function(DateTime dateTime) onChanged;

  @override
  Widget build(BuildContext context) {
    return dp.DayPicker.single(
      selectedDate: selectedDate,
      onChanged: onChanged,
      firstDate: firstDate,
      lastDate: lastDate,
      datePickerStyles: _getStyle(context),
      datePickerLayoutSettings: const dp.DatePickerLayoutSettings(
        maxDayPickerRowCount: 5,
        showPrevMonthEnd: false,
        showNextMonthStart: false,
      ),
    );
  }

  dp.DatePickerRangeStyles _getStyle(BuildContext context) {
    return dp.DatePickerRangeStyles(
      selectedDateStyle:
          Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
      currentDateStyle: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: AppColors.dateSelected),
      selectedSingleDateDecoration: const BoxDecoration(
        color: AppColors.dateSelected,
        shape: BoxShape.circle,
      ),
      dayHeaderStyle: DayHeaderStyle(
        textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.dayName,
              fontWeight: FontWeight.w400,
            ),
      ),
      defaultDateTextStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.dayName,
            fontWeight: FontWeight.w400,
          ),
      dayHeaderTitleBuilder:
          (int dayOfTheWeek, List<String> localizedHeaders) =>
              localizedHeaders[dayOfTheWeek].substring(0, 3),
      nextIcon: const Icon(Icons.fast_forward),
      prevIcon: const Icon(Icons.fast_rewind),
    );
  }
}
