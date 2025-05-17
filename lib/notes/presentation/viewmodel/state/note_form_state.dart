import 'package:dart_mappable/dart_mappable.dart';
import 'package:notex/core/exceptions/validation_exception.dart';
import 'package:notex/notes/domain/entities/note.dart';

part 'note_form_state.mapper.dart';

@MappableClass()
class NoteFormState with NoteFormStateMappable {
  final String title;
  final String content;
  final Note? existing;
  final ValidationException? error;

  const NoteFormState({
    this.title = '',
    this.content = '',
    this.existing,
    this.error,
  });

  bool get isEditing => existing != null;
}
