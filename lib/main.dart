import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notex/di/localizations.dart';
import 'package:notex/notex_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initLocale();

  runApp(const ProviderScope(child: NotexApp()));
}
