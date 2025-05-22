import 'package:drift/drift.dart';
import 'package:notex/core/data/drift_database.dart';
import 'package:notex/core/types/sort_direction.dart';
import 'package:notex/notes/app/types/note_order.dart';
import 'package:notex/notes/data/models/drift_note.dart';
import 'package:notex/notes/domain/entities/note.dart';

part 'notes_dao.g.dart';

@DriftAccessor(tables: [Notes])
class NotesDao extends DatabaseAccessor<AppDatabase> with _$NotesDaoMixin {
  NotesDao(super.db);

  Future<List<Note>> getNotesPaged({required int offset, required int limit, required NoteOrder order, String? query}) {
    final q = select(notes)..limit(limit, offset: offset);

    if (query != null && query.isNotEmpty) {
      q.where((tbl) => tbl.title.likeExp(Variable('%$query%')) | tbl.content.likeExp(Variable('%$query%')));
    }

    q.orderBy([
      (tbl) => OrderingTerm(
        expression: switch (order.field) {
          NoteSortField.title => tbl.title.lower(),
          NoteSortField.updatedAt => tbl.updatedAt,
          NoteSortField.createdAt => tbl.createdAt,
        },
        mode: order.direction == SortDirection.desc ? OrderingMode.desc : OrderingMode.asc,
      ),
    ]);

    return q.get();
  }

  Future<Note> insertNote(Note note) =>
      into(notes).insertReturning(NotesCompanion.insert(title: note.title, content: note.content));

  Future<int> updateNote(Note note) => (update(notes)..where((tbl) => tbl.id.equals(note.id))).write(
    NotesCompanion(title: Value(note.title), content: Value(note.content), updatedAt: Value(DateTime.timestamp())),
  );

  Future<int> deleteNote(int id) => (delete(notes)..where((tbl) => tbl.id.equals(id))).go();
}
