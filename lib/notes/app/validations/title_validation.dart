import 'package:notex/core/exceptions/validation_exception.dart';

const titleMinLength = 3;
const titleMaxLength = 255;

class TitleValidation {
  static List<Invalidation> validate(String title) {
    final errors = <Invalidation>[];
    final trimmed = title.trim();

    if (trimmed.isEmpty) {
      errors.add(const Invalidation('title', 'Заголовок обязателен'));
    }

    if (trimmed.length < titleMinLength) {
      errors.add(
        const Invalidation('title', 'Минимум $titleMinLength символа'),
      );
    } else if (trimmed.length > titleMaxLength) {
      errors.add(
        const Invalidation('title', 'Максимум $titleMaxLength символов'),
      );
    }

    return errors;
  }
}
