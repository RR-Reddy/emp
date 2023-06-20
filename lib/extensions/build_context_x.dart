import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  void unfoucs() => FocusScope.of(this).unfocus();

  NavigatorState get nav => Navigator.of(this);
}
