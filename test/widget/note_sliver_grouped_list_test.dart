import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notex/notes/app/types/note_order.dart';
import 'package:notex/notes/presentation/list/note_sliver_grouped_list.dart';
import 'package:notex/notex_app.dart';

import '../mocks.dart';

void main() {
  setUpAll(initTestDefault);

  testWidgets('группирует по первой букве (включая emoji)', (tester) async {
    final notes = [
      fakeNote(id: 1, title: '🔥 Fire'),
      fakeNote(id: 2, title: 'Apple'),
      fakeNote(id: 3, title: 'Альфа'),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              NoteSliverGroupedList(
                notes: notes,
                order: NoteOrder.byTitleAsc(),
                hasMore: false,
                loadMore: () {},
                onOpen: (_) async {},
                onDelete: (_) async {},
                onUndo: () {},
              ),
            ],
          ),
        ),
      ),
    );

    final headers =
        tester
            .widgetList<Text>(find.byType(Text))
            .map((e) => e.data)
            .where((s) => s != null && s.isNotEmpty)
            .toList();

    expect(headers, containsAllInOrder(['🔥', 'A', 'А']));
  });

  testWidgets('формат дат: Сегодня / Вчера / Позавчера', (tester) async {
    final now = DateTime.now();

    final notes = [
      fakeNote(id: 1, title: 'Заметка 1', created: now, updated: now),
      fakeNote(
        id: 2,
        title: 'Заметка 2',
        created: now.subtract(const Duration(days: 1)),
        updated: now.subtract(const Duration(days: 1)),
      ),
      fakeNote(
        id: 3,
        title: 'Заметка 3',
        created: now.subtract(const Duration(days: 2)),
        updated: now.subtract(const Duration(days: 2)),
      ),
    ];

    await tester.pumpWidget(
      ConfiguredApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              NoteSliverGroupedList(
                notes: notes,
                order: NoteOrder.byUpdatedDesc(),
                hasMore: false,
                loadMore: () {},
                onOpen: (_) async {},
                onDelete: (_) async {},
                onUndo: () {},
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Сегодня'), findsOneWidget);
    expect(find.text('Вчера'), findsOneWidget);
    expect(find.text('Позавчера'), findsOneWidget);
  });
}
