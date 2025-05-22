import 'package:notex/notes/app/validations/note_validator.dart';
import 'package:notex/notes/domain/entities/note.dart';
import 'package:notex/notes/domain/repositories/note_repository.dart';

class CreateNote {
  CreateNote(this.repository);
  final NoteRepository repository;

  Future<void> call(Note note) async {
    NoteValidator().validate(title: note.title, content: note.content);

    await repository.createNote(note);
  }
}
