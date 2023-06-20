import 'package:bloc/bloc.dart';

class EmpDateCubit extends Cubit<DateTime?> {
  EmpDateCubit({
    required this.isStartDate,
    required this.initialSelectedDate,
    required this.firstDate,
    required this.lastDate,
  }) : super(initialSelectedDate);

  final bool isStartDate;
  final DateTime initialSelectedDate;
  final DateTime firstDate;
  final DateTime lastDate;

  void updateDate(DateTime? dateTime) {
    emit(dateTime);
  }
}
