import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notex/core/theme/app_theme.dart';

@immutable
class AppConfig {
  const AppConfig({
    this.appTheme = const AppTheme(),
    this.locales = const [Locale('ru'), Locale('en')],
    this.delegates = _kDefaultDelegates,
  });

  final AppTheme appTheme;

  final Iterable<Locale> locales;

  final Iterable<LocalizationsDelegate<dynamic>> delegates;

  static const _kDefaultDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}

const defaultConfig = AppConfig();
