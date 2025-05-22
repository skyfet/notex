import 'package:notex/core/exceptions/invalidation.dart';

class ValidationException implements Exception {
  const ValidationException(this.invalidations);

  final List<Invalidation> invalidations;

  bool hasErrorFor(String field) => invalidations.any((e) => e.field == field);

  List<String> allErrorsFor(String field) => invalidations.where((e) => e.field == field).map((e) => e.error).toList();

  String? errorTextFor(String field, {String separator = ' • ', int maxTake = 3}) {
    final messages = allErrorsFor(field);
    if (messages.isEmpty) {
      return null;
    }
    return messages.take(maxTake).join(separator);
  }

  Map<String, List<String>> asMap() {
    final map = <String, List<String>>{};
    for (final e in invalidations) {
      map.putIfAbsent(e.field, () => []).add(e.error);
    }
    return map;
  }

  @override
  String toString() {
    final text = invalidations.map((e) => e.toString()).join(', ');
    return 'ValidationException($text)';
  }
}
