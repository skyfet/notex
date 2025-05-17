import 'package:notex/core/exceptions/validation_exception.dart';

const contentMaxLength = 10000;

class ContentValidation {
  static List<Invalidation> validate(String title) {
    final errors = <Invalidation>[];
    final trimmed = title.trim();

    if (trimmed.length > contentMaxLength) {
      errors.add(
        const Invalidation('content', 'Максимум $contentMaxLength символов'),
      );
    }

    return errors;
  }
}
