import 'package:emp/extensions/index.dart';
import 'package:emp/pages/home/bloc/emp_list_cubit.dart';
import 'package:emp/pages/home/widgets/index.dart';
import 'package:emp/pages/index.dart';
import 'package:emp/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      backgroundColor: AppColors.darkBg,
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () => context.nav.pushNamed(AddEditPage.routeName),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: const [
          Expanded(
            child: _BodyWidget(),
          ),
          BottomDeleteHintWidget(),
        ],
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmpListCubit, EmpListState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.list.isEmpty) {
          return const Center(child: EmptyStateWidget());
        }

        return const ListWidget();
      },
    );
  }
}
