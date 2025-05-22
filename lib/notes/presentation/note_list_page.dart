import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notex/notes/domain/entities/note.dart';
import 'package:notex/notes/presentation/list/note_sliver_grouped_list.dart';
import 'package:notex/notes/presentation/list/notes_search_bar.dart';
import 'package:notex/notes/presentation/list/ordering_button.dart';
import 'package:notex/notes/presentation/note_form_page.dart';
import 'package:notex/notes/presentation/viewmodel/notes_list_viewmodel.dart';

class NotesListPage extends ConsumerWidget {
  const NotesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notesListViewModelProvider);
    final vm = ref.read(notesListViewModelProvider.notifier);

    Future<void> open([Note? note]) async {
      final changed =
          await Navigator.of(context).push<bool>(MaterialPageRoute(builder: (_) => NoteFormPage(note: note))) ?? false;

      if (changed) await vm.refresh();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Заметки'),
        bottom:
            state.isSearching || state.hasAnyNotes
                ? PreferredSize(
                  preferredSize: const Size.fromHeight(80),
                  child: Padding(padding: const EdgeInsets.all(16), child: NotesSearchBar(onQuery: vm.setQuery)),
                )
                : null,
        actions: [
          if (state.isLoading) const SizedBox.square(dimension: 16, child: CircularProgressIndicator(strokeWidth: 2)),
          OrderingButton(order: state.order, onChange: vm.setOrder),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed('/settings'),
            onLongPress: () async {
              if (!kDebugMode) return;
              await _generateFakes(context, vm);
            },
          ),
        ],
      ),
      body: switch ((state.isInitialLoading, state.error, state.notes.isEmpty)) {
        (true, _, _) => const Center(child: CircularProgressIndicator()),
        (_, String e, _) => Center(child: Text('Ошибка: $e')),
        (_, _, true) => Center(child: Text(state.query.isEmpty ? 'Нет заметок' : 'Ничего не найдено')),
        _ => CustomScrollView(
          slivers: [
            NoteSliverGroupedList(
              notes: state.notes,
              order: state.order,
              hasMore: state.hasMore,
              loadMore: vm.loadMore,
              onOpen: open,
              onDelete: vm.delete,
              onUndo: vm.restore,
              searchQuery: state.query,
            ),
          ],
        ),
      },
      floatingActionButton: FloatingActionButton(onPressed: open, child: const Icon(Icons.add)),
    );
  }
}

Future<void> _generateFakes(BuildContext context, NotesListViewModel vm) async {
  int? count;

  final ok = await showDialog<bool>(
    context: context,
    builder:
        (ctx) => AlertDialog(
          title: const Text('Генерация тестовых заметок'),
          content: TextField(
            decoration: const InputDecoration(labelText: 'Введите количество (<1000)'),
            onChanged: (v) => count = int.tryParse(v),
            maxLength: 3,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Отмена')),
            TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Создать')),
          ],
        ),
  );

  if ((ok ?? false) && count != null && count! > 0 && count! < 1000 && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Генерирую заметки…')));
    await vm.generateFake(count!);
    if (context.mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$count заметок создано')));
    }
  }
}
