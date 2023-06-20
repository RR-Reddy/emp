import 'package:flutter/material.dart';

final roleList = [
  'Product Designer',
  'Flutter Developer',
  'QA Tester',
  'Product Owner',
];

class EmpRoleBottomSheet {
  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String?>(
      context: context,
      builder: (_) => const _SheetBodyWidget(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }
}

class _SheetBodyWidget extends StatelessWidget {
  const _SheetBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final role in roleList) ...{
          _OptionTileWidget(value: role),
        },
      ],
    );
  }
}

class _OptionTileWidget extends StatelessWidget {
  const _OptionTileWidget({
    Key? key,
    required this.value,
  }) : super(key: key);
  final String value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(value),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(value),
          ),
          Container(
            height: 2,
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}
