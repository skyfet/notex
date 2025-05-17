import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notex/core/data/drift_database.dart' show AppDatabase;

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
