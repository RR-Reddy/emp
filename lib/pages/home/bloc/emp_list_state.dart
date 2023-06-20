part of 'emp_list_cubit.dart';

class EmpListState {
  final List<Employee> list;
  final DateTime updatedTimeStamp;
  final bool isLoading;

  const EmpListState({
    required this.list,
    required this.updatedTimeStamp,
    required this.isLoading,
  });

  @override
  String toString() {
    return 'EmpListState{list: $list, updatedTimeStamp: $updatedTimeStamp, isLoading: $isLoading}';
  }

  EmpListState copyWith({
    List<Employee>? list,
    DateTime? updatedTimeStamp,
    bool? isLoading,
  }) {
    return EmpListState(
      list: list ?? this.list
        ..sort((a, b) => a.id.compareTo(b.id)),
      updatedTimeStamp: updatedTimeStamp ?? this.updatedTimeStamp,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
