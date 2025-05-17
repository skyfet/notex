import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notex/core/theme/theme_mode_preference.dart';

final settingsViewModelProvider =
    StateNotifierProvider<SettingsViewModel, ThemeMode>(
      (ref) => SettingsViewModel(pref: ThemeModePreference()),
    );

class SettingsViewModel extends StateNotifier<ThemeMode> {
  final ThemeModePreference pref;

  SettingsViewModel({required this.pref}) : super(ThemeMode.system) {
    _load();
  }

  Future<void> _load() async {
    state = await pref.get();
  }

  Future<void> toggle(ThemeMode mode) async {
    state = mode;
    await pref.set(mode);
  }
}
