import 'package:notex/core/exceptions/validation_exception.dart';

class Invalidation {
  final String field;
  final String error;

  const Invalidation(this.field, this.error);

  @override
  String toString() => '$field: $error';
}

extension ExceptInvalidations on List<Invalidation> {
  List<Invalidation> extendWith(List<Invalidation> invalidations) {
    return [...this, ...invalidations];
  }

  void throwIfInvalid() {
    if (isNotEmpty) throw ValidationException(this);
  }
}
