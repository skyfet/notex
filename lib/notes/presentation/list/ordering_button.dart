import 'package:flutter/material.dart';
import 'package:notex/notes/app/types/note_order.dart';

class OrderingButton extends StatelessWidget {
  const OrderingButton({
    super.key,
    required this.order,
    required this.onChange,
  });

  final NoteOrder order;
  final Function(NoteOrder) onChange;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<NoteOrder>(
      icon: const Icon(Icons.sort),
      initialValue: order,
      onSelected: onChange,
      itemBuilder:
          (_) => [
            PopupMenuItem(
              value: NoteOrder.byUpdatedDesc(),
              child: Text('Дата обновления ↓'),
            ),
            PopupMenuItem(
              value: NoteOrder.byUpdatedAsc(),
              child: Text('Дата обновления ↑'),
            ),
            PopupMenuItem(
              value: NoteOrder.byCreatedDesc(),
              child: Text('Дата создания ↓'),
            ),
            PopupMenuItem(
              value: NoteOrder.byCreatedAsc(),
              child: Text('Дата создания ↑'),
            ),
            PopupMenuItem(
              value: NoteOrder.byTitleAsc(),
              child: Text('Заголовок A–Я'),
            ),
            PopupMenuItem(
              value: NoteOrder.byTitleDesc(),
              child: Text('Заголовок Я–А'),
            ),
          ],
    );
  }
}
