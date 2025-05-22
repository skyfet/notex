import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModePreference {
  static const _key = 'theme_mode';

  Future<void> set(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name);
  }

  Future<ThemeMode> get() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key);

    return ThemeMode.values.firstWhere((m) => m.name == value, orElse: () => ThemeMode.system);
  }
}
