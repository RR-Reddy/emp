import 'package:flutter/material.dart';

class ThemesUtils {
  static getThemeData() {
    final ThemeData base = ThemeData(
      primarySwatch: Colors.blue,
    );
    return base.copyWith(
      appBarTheme: _buildAppbarTheme(base),
    );
  }

  static AppBarTheme _buildAppbarTheme(ThemeData base) {
    return base.appBarTheme.copyWith(
      titleTextStyle: base.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
}
