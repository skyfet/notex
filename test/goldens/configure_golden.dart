import 'dart:async';
import 'package:drift/native.dart';
import 'package:flutter/rendering.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:notex/core/data/drift_database.dart';
import 'package:notex/di/app_providers.dart';
import 'package:riverpod/riverpod.dart' show Override;

import '../mocks.dart';

Future<void> initGoldens() async {
  await initTestDefault();
  debugPaintSizeEnabled = false; // никаких рамок-отладки
  await loadAppFonts(); // единственное, что берём из пакета
}

Override inMemoryDbOverride() {
  final db = AppDatabase(NativeDatabase.memory());
  return appDatabaseProvider.overrideWithValue(db);
}
