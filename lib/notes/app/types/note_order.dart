import 'package:dart_mappable/dart_mappable.dart';
import 'package:notex/core/types/sort_direction.dart';

part 'note_order.mapper.dart';

enum NoteSortField { title, createdAt, updatedAt }

@MappableClass()
class NoteOrder with NoteOrderMappable {
  const NoteOrder({required this.field, required this.direction});

  factory NoteOrder.byTitleAsc() => const NoteOrder(field: NoteSortField.title, direction: SortDirection.asc);

  factory NoteOrder.byTitleDesc() => const NoteOrder(field: NoteSortField.title, direction: SortDirection.desc);

  factory NoteOrder.byCreatedAsc() => const NoteOrder(field: NoteSortField.createdAt, direction: SortDirection.asc);

  factory NoteOrder.byCreatedDesc() => const NoteOrder(field: NoteSortField.createdAt, direction: SortDirection.desc);

  factory NoteOrder.byUpdatedDesc() => const NoteOrder(field: NoteSortField.updatedAt, direction: SortDirection.desc);

  factory NoteOrder.byUpdatedAsc() => const NoteOrder(field: NoteSortField.updatedAt, direction: SortDirection.asc);
  final NoteSortField field;
  final SortDirection direction;
}
