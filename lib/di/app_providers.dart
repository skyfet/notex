import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notex/core/data/drift_database.dart' show AppDatabase;
import 'package:notex/core/services/gemini_service.dart';

const _geminiApiKey = String.fromEnvironment('GEMINI_API_KEY');

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

final geminiServiceProvider =
    Provider<GeminiService>((ref) => GeminiService(_geminiApiKey));
