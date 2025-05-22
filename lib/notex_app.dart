import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notex/core/configured_app.dart';
import 'package:notex/core/routes/app_routes.dart';
import 'package:notex/settings/settings_viewmodel.dart';

class NotexApp extends ConsumerWidget {
  const NotexApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(settingsViewModelProvider);
    return ConfiguredApp(themeMode: mode, routes: appRoutes());
  }
}
