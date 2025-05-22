import 'package:flutter/material.dart';
import 'package:notex/core/app_config.dart';
import 'package:notex/di/values.dart';

class ConfiguredApp extends StatelessWidget {
  const ConfiguredApp({
    super.key,
    this.title = 'NoteX',
    this.config = defaultConfig,
    this.themeMode = ThemeMode.system,
    this.routes = const {},
    this.home,
  });

  final AppConfig config;

  final String title;
  final Map<String, WidgetBuilder> routes;
  final Widget? home;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    themeMode: themeMode,
    locale: const Locale(defaultLocale),
    theme: config.appTheme.light(),
    darkTheme: config.appTheme.dark(),
    supportedLocales: config.locales,
    localizationsDelegates: config.delegates,
    routes: routes,
    home: home,
  );
}
