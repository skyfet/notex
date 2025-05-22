import 'package:flutter/material.dart';
import 'package:notex/notes/app/types/note_order.dart';

class OrderingButton extends StatelessWidget {
  const OrderingButton({required this.order, required this.onChange, super.key});

  final NoteOrder order;
  final void Function(NoteOrder) onChange;

  @override
  Widget build(BuildContext context) => PopupMenuButton<NoteOrder>(
    icon: const Icon(Icons.sort),
    initialValue: order,
    onSelected: onChange,
    itemBuilder:
        (_) => [
          PopupMenuItem(value: NoteOrder.byUpdatedDesc(), child: const Text('Дата обновления ↓')),
          PopupMenuItem(value: NoteOrder.byUpdatedAsc(), child: const Text('Дата обновления ↑')),
          PopupMenuItem(value: NoteOrder.byCreatedDesc(), child: const Text('Дата создания ↓')),
          PopupMenuItem(value: NoteOrder.byCreatedAsc(), child: const Text('Дата создания ↑')),
          PopupMenuItem(value: NoteOrder.byTitleAsc(), child: const Text('Заголовок A–Я')),
          PopupMenuItem(value: NoteOrder.byTitleDesc(), child: const Text('Заголовок Я–А')),
        ],
  );
}
