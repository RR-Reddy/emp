import 'package:emp/pages/home/bloc/emp_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomDeleteHintWidget extends StatelessWidget {
  const BottomDeleteHintWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmpListCubit, EmpListState>(
      builder: (context, state) {
        if (state.list.isEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: 34,
            top: 8,
          ),
          child: const Text('Swipe left to delete'),
        );
      },
    );
  }
}
