import 'package:notex/notes/domain/repositories/note_repository.dart';

class DeleteNote {
  DeleteNote(this.repository);
  final NoteRepository repository;

  Future<void> call(int id) => repository.deleteNote(id);
}
