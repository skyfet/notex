import 'package:notex/notes/app/types/note_order.dart';
import 'package:notex/notes/domain/entities/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getNotesPaged({required int offset, required int limit, required NoteOrder order, String? query});

  Future<void> createNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(int id);
}
