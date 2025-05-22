import 'package:dart_mappable/dart_mappable.dart';
import 'package:notex/core/types/sort_direction.dart';
import 'package:notex/notes/app/types/note_order.dart';
import 'package:notex/notes/domain/entities/note.dart';

part 'note_list_state.mapper.dart';

@MappableClass()
class NotesListState with NotesListStateMappable {
  const NotesListState({
    this.notes = const [],
    this.query = '',
    this.order = const NoteOrder(field: NoteSortField.updatedAt, direction: SortDirection.desc),
    this.isInitialLoading = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
  });
  final List<Note> notes;
  final String query;
  final NoteOrder order;
  final bool isLoading;
  final bool isInitialLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
}
