import 'package:notex/core/exceptions/validation_exception.dart';

class Invalidation {
  const Invalidation(this.field, this.error);

  final String field;
  final String error;

  @override
  String toString() => '$field: $error';
}

extension ExceptInvalidations on List<Invalidation> {
  List<Invalidation> extendWith(List<Invalidation> invalidations) => [...this, ...invalidations];

  void throwIfInvalid() {
    if (isNotEmpty) {
      throw ValidationException(this);
    }
  }
}
