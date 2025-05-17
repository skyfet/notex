import 'package:flutter/material.dart';
import 'package:notex/notes/presentation/note_list_page.dart';
import 'package:notex/settings/settings_page.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (_) => const NotesListPage(),
    '/settings': (_) => const SettingsPage(),
  };
}
