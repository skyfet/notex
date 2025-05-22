import 'package:notex/core/exceptions/invalidation.dart';
import 'package:notex/notes/app/validations/content_validation.dart';
import 'package:notex/notes/app/validations/title_validation.dart';

class NoteValidator {
  void validate({required String title, required String content}) =>
      <Invalidation>[]
          .extendWith(TitleValidation().validate(title))
          .extendWith(ContentValidation().validate(content))
          .throwIfInvalid();
}
