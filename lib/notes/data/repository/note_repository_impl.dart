import 'package:notex/notes/app/types/note_order.dart';
import 'package:notex/notes/data/datasources/notes_dao.dart';
import 'package:notex/notes/domain/entities/note.dart';
import 'package:notex/notes/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  NoteRepositoryImpl(this.dao);
  final NotesDao dao;

  @override
  Future<List<Note>> getNotesPaged({
    required int offset,
    required int limit,
    required NoteOrder order,
    String? query,
  }) => dao.getNotesPaged(offset: offset, limit: limit, query: query, order: order);

  @override
  Future<void> createNote(Note note) => dao.insertNote(note);

  @override
  Future<void> updateNote(Note note) => dao.updateNote(note);

  @override
  Future<void> deleteNote(int id) => dao.deleteNote(id);
}
