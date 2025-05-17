import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notex/core/routes/app_routes.dart';
import 'package:notex/core/theme/app_theme.dart';
import 'package:notex/di/values.dart';
import 'package:notex/settings/settings_viewmodel.dart';

class NotexApp extends ConsumerWidget {
  const NotexApp({super.key, this.routes = const {}});

  final Map<String, Widget Function(BuildContext)> routes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(settingsViewModelProvider);
    return ConfiguredApp(themeMode: mode, routes: AppRoutes.routes);
  }
}

class ConfiguredApp extends MaterialApp
    with AppThemeMixin, AppLocalizationMixin {
  const ConfiguredApp({
    super.key,
    super.debugShowCheckedModeBanner = false,
    super.title = 'NoteX',
    super.routes,
    super.themeMode,
    super.theme,
    super.home,
  });
}

mixin AppThemeMixin {
  ThemeData get theme => AppTheme.light();
  ThemeData get darkTheme => AppTheme.dark();
}

mixin AppLocalizationMixin {
  Locale get locale => Locale(defaultLocale);
  List<Locale> get supportedLocales => const [Locale(defaultLocale)];
  List<LocalizationsDelegate> get localizationsDelegates => const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
