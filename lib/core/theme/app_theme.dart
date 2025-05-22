import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();

  static const _seed = Colors.purple;

  ThemeData light() =>
      ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.light), useMaterial3: true);

  ThemeData dark() =>
      ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark), useMaterial3: true);
}
