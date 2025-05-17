import 'package:notex/core/exceptions/validation_exception.dart';
import 'content_validation.dart';
import 'title_validation.dart';

class NoteValidator {
  static void validate({required String title, required String content}) =>
      <Invalidation>[]
          .extendWith(TitleValidation.validate(title))
          .extendWith(ContentValidation.validate(content))
          .throwIfInvalid();
}
