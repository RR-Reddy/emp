import 'package:emp/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CtaButtonWidget extends StatelessWidget {
  const CtaButtonWidget({
    Key? key,
    required this.onTap,
    required this.title,
    this.isSecondary = false,
  }) : super(key: key);
  final VoidCallback onTap;
  final String title;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color:
              isSecondary ? AppColors.dateUnSelected : AppColors.dateSelected,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: isSecondary ? AppColors.dateSelected : Colors.white,
              ),
        ),
      ),
    );
  }
}
