import 'package:notex/core/types/row_items.dart';
import 'package:notex/notes/domain/entities/note.dart';

class NoteItem extends RowItem {
  final Note note;
  NoteItem(this.note);
}
