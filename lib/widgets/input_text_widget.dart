import 'package:emp/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  const InputTextWidget({
    Key? key,
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.readOnly = false,
    this.initialValue,
    this.onTap,
    this.suffixIcon,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final bool readOnly;
  final String? initialValue;
  final GestureTapCallback? onTap;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      onChanged: onChanged,
      initialValue: initialValue,
      onTap: onTap,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        prefixIcon: prefixIcon,
        prefixIconConstraints: const BoxConstraints(
          maxWidth: 32,
          minWidth: 32,
          maxHeight: 18,
          minHeight: 18,
        ),
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(
          maxWidth: 32,
          minWidth: 32,
          maxHeight: 10,
          minHeight: 10,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}
