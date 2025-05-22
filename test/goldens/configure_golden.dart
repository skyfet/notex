import 'package:drift/native.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:notex/core/data/drift_database.dart';
import 'package:notex/di/app_providers.dart';
import 'package:riverpod/riverpod.dart' show Override;

import '../mocks.dart';

Future<void> initGoldens() async {
  await initTestDefault();
  await loadAppFonts();
}

Override inMemoryDbOverride() {
  final db = AppDatabase(NativeDatabase.memory());
  return appDatabaseProvider.overrideWithValue(db);
}
