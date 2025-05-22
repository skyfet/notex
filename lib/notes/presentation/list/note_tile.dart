import 'package:flutter/material.dart';
import 'package:notex/core/presentation/widgets/highlight_text.dart';
import 'package:notex/notes/domain/entities/note.dart';
import 'package:timeago/timeago.dart' as timeago;

enum NoteTileVariant { regular, compact }

class NoteTile extends StatelessWidget {
  const NoteTile({
    required this.note,
    required this.onTap,
    super.key,
    this.onDelete,
    this.onUndo,
    this.variant = NoteTileVariant.regular,
    this.highlightText = '',
  });

  final Note note;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onUndo;
  final NoteTileVariant variant;
  final String highlightText;

  bool get _isDismissible => onDelete != null && variant == NoteTileVariant.regular;

  @override
  Widget build(BuildContext context) {
    final content = _TileContent(note: note, variant: variant, highlightText: highlightText, onTap: onTap);

    return _isDismissible ? _buildDismissible(context, content) : content;
  }

  Widget _buildDismissible(BuildContext context, Widget child) => Dismissible(
    key: ValueKey(note.id),
    background: Container(
      color: Theme.of(context).colorScheme.error,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(Icons.delete, color: Colors.white),
    ),
    direction: DismissDirection.endToStart,
    onDismissed: (_) {
      onDelete?.call();

      if (onUndo != null)
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: const Text('Заметка удалена'),
              action: SnackBarAction(label: 'Отменить', onPressed: onUndo!),
            ),
          );
    },
    child: child,
  );
}

class _TileContent extends StatelessWidget {
  const _TileContent({required this.note, required this.variant, required this.onTap, required this.highlightText});
  final VoidCallback onTap;

  final Note note;
  final NoteTileVariant variant;
  final String highlightText;

  @override
  Widget build(BuildContext context) {
    final created = timeago.format(note.createdAt, locale: 'ru');
    final updated = timeago.format(note.updatedAt, locale: 'ru');

    return ListTile(
      key: ValueKey(note.id),
      title: HighlightText(note.title, highlight: highlightText),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (note.content.isNotEmpty)
            HighlightText(
              note.content,
              highlight: highlightText,
              contextClip: true,
              maxLines: highlightText.isEmpty ? 2 : 4,
            ),
          if (variant == NoteTileVariant.regular) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 4),
                Text(created, style: Theme.of(context).textTheme.bodySmall),
                if (created != updated) ...[
                  const SizedBox(width: 8),
                  const Icon(Icons.history, size: 16),
                  const SizedBox(width: 4),
                  Text(updated, style: Theme.of(context).textTheme.bodySmall),
                ],
              ],
            ),
          ],
        ],
      ),
      onTap: onTap,
    );
  }
}
