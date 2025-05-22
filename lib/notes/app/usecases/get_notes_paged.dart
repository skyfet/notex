import 'package:notex/notes/app/types/note_order.dart';
import 'package:notex/notes/domain/entities/note.dart';
import 'package:notex/notes/domain/repositories/note_repository.dart';

class GetNotesPaged {
  GetNotesPaged(this.repository);
  final NoteRepository repository;

  Future<List<Note>> call({required int offset, required int limit, required NoteOrder order, String? query}) =>
      repository.getNotesPaged(offset: offset, limit: limit, query: query, order: order);
}
