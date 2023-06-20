import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String get toUserReadFormat => DateFormat('dd MMM yyyy').format(this);

  bool isNextWeekDay(int weekDay) =>
      DateTime(year, month, day) == nextWeekDay(weekDay);

  DateTime nextWeekDay(int weekDay) {
    var day = DateTime.now();

    var isMatched = false;
    const oneDay = Duration(days: 1);

    while (!isMatched) {
      day = day.add(oneDay);
      if (day.weekday == weekDay) {
        return DateTime(day.year, day.month, day.day);
      }
    }
  }

  bool get isToday {
    final today = DateTime.now();
    return DateTime(today.year, today.month, today.day) ==
        DateTime(year, month, day);
  }

  DateTime get afterOneWeek => DateTime.now().add(const Duration(days: 7));

  bool get isAfterWeek {
    return DateTime(year, month, day) ==
        DateTime(afterOneWeek.year, afterOneWeek.month, afterOneWeek.day);
  }
}
