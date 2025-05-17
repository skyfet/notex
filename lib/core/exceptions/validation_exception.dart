import 'package:notex/core/exceptions/invalidation.dart';
export 'invalidation.dart';

class ValidationException implements Exception {
  final List<Invalidation> invalidations;

  ValidationException(this.invalidations);

  bool hasErrorFor(String field) {
    return invalidations.any((e) => e.field == field);
  }

  List<String> allErrorsFor(String field) {
    return invalidations
        .where((e) => e.field == field)
        .map((e) => e.error)
        .toList();
  }

  String? errorTextFor(
    String field, {
    String separator = ' • ',
    int maxTake = 3,
  }) {
    final messages = allErrorsFor(field);
    if (messages.isEmpty) return null;
    return messages.take(maxTake).join(separator);
  }

  Map<String, List<String>> asMap() {
    final map = <String, List<String>>{};
    for (var e in invalidations) {
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
