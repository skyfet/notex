import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notex/core/types/row_items.dart';
import 'package:notex/di/values.dart';
import 'package:notex/notes/app/types/note_item.dart';
import 'package:notex/notes/app/types/note_order.dart';
import 'package:notex/notes/domain/entities/note.dart';
import 'package:notex/notes/presentation/list/note_tile.dart';

class NoteSliverGroupedList extends StatefulWidget {
  const NoteSliverGroupedList({
    required this.notes,
    required this.order,
    required this.hasMore,
    required this.loadMore,
    required this.onOpen,
    required this.onDelete,
    required this.onUndo,
    this.searchQuery = '',
    super.key,
  });

  final List<Note> notes;
  final NoteOrder order;
  final bool hasMore;
  final VoidCallback loadMore;
  final Future<void> Function(Note note) onOpen;
  final Future<void> Function(int id) onDelete;
  final VoidCallback onUndo;
  final String searchQuery;

  @override
  State<NoteSliverGroupedList> createState() => _NoteSliverGroupedListState();
}

class _NoteSliverGroupedListState extends State<NoteSliverGroupedList> {
  late List<RowItem<dynamic>> _rows;

  @override
  void initState() {
    super.initState();
    _rows = _buildRows();
  }

  @override
  void didUpdateWidget(covariant NoteSliverGroupedList old) {
    super.didUpdateWidget(old);
    if (old.notes != widget.notes || old.hasMore != widget.hasMore) {
      _rows = _buildRows();
    }
  }

  @override
  Widget build(BuildContext context) =>
      SliverList(delegate: SliverChildBuilderDelegate(_builder, childCount: _rows.length));

  Widget? _builder(BuildContext context, int i) {
    final row = _rows[i];

    switch (row) {
      case HeaderItem groupHeader:
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Text(groupHeader.value, style: Theme.of(context).textTheme.titleMedium),
        );

      case LoaderItem _:
        WidgetsBinding.instance.addPostFrameCallback((_) => widget.loadMore());
        return const Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator()));

      case NoteItem item:
        return NoteTile(
          note: item.value,
          onTap: () => widget.onOpen(item.value),
          onDelete: () => _handleDelete(item.value.id),
          onUndo: widget.onUndo,
          highlightText: widget.searchQuery,
        );
    }
    return null;
  }

  List<RowItem<dynamic>> _buildRows() {
    if (widget.notes.isEmpty) {
      return widget.hasMore ? [const LoaderItem()] : [];
    }

    if (widget.order.field == NoteSortField.title) {
      String? currentLetter;
      final rows = <RowItem<dynamic>>[];

      for (final n in widget.notes) {
        final trimmed = n.title.trim().toUpperCase();
        final letter = trimmed.isEmpty ? '#' : trimmed.characters.first;
        if (letter != currentLetter) {
          currentLetter = letter;
          rows.add(HeaderItem(letter));
        }
        rows.add(NoteItem(n));
      }

      if (widget.hasMore) rows.add(const LoaderItem());
      return rows;
    }

    DateTime pick(Note n) => widget.order.field == NoteSortField.createdAt ? n.createdAt : n.updatedAt;

    DateTime? currentDay;
    final rows = <RowItem<dynamic>>[];

    for (final n in widget.notes) {
      final d = pick(n);
      final day = DateTime(d.year, d.month, d.day);
      if (currentDay == null || !day.isAtSameMomentAs(currentDay)) {
        currentDay = day;
        rows.add(HeaderItem(_prettyDay(day)));
      }
      rows.add(NoteItem(n));
    }

    if (widget.hasMore) rows.add(const LoaderItem());
    return rows;
  }

  String _prettyDay(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(date.year, date.month, date.day);
    final diff = today.difference(day).inDays;

    if (diff == 0) return 'Сегодня';
    if (diff == 1) return 'Вчера';
    if (diff == 2) return 'Позавчера';
    if (today.year == day.year) {
      return DateFormat.MMMd(defaultLocale).format(date);
    }
    return DateFormat.yMMMd(defaultLocale).format(day);
  }

  Future<void> _handleDelete(int id) async {
    final backup = List<RowItem<dynamic>>.from(_rows);

    setState(() {
      _rows.removeWhere((row) => row is NoteItem && row.value.id == id);
    });

    try {
      await widget.onDelete(id);
    } on Object catch (e) {
      if (mounted) {
        setState(() => _rows = backup);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Не удалось удалить заметку: $e')));
      }
    }
  }
}
