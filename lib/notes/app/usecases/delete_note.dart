import 'package:notex/notes/domain/repositories/note_repository.dart';

class DeleteNote {
  final NoteRepository repository;

  DeleteNote(this.repository);

  Future<void> call(int id) => repository.deleteNote(id);
}
