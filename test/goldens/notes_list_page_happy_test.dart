import 'dart:ui' as ui;
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:notex/di/notes_providers.dart';
import 'package:notex/notex_app.dart';
import 'package:notex/notes/presentation/note_list_page.dart';

import '../mocks.dart';
import 'configure_golden.dart';

void main() {
  setUpAll(() => initGoldens());

  testWidgets('NotesListPage - phone, tablet, dark phone', (tester) async {
    // 1. мок-данные
    final faker = Faker(seed: 888);
    final notes = List.generate(
      20,
      (i) => fakeNote(
        id: i,
        title: faker.lorem.words(3).join(' '),
        content: faker.lorem.sentences(4).join(' '),
      ),
    );

    final getPaged = MockGetNotesPaged();
    when(
      () => getPaged(
        offset: 0,
        limit: any(named: 'limit'),
        query: '',
        order: any(named: 'order'),
      ),
    ).thenAnswer((_) async => notes);

    // 2. Провайдеры
    final scope = ProviderScope(
      overrides: [
        getNotesPagedProvider.overrideWithValue(getPaged),
        inMemoryDbOverride(),
      ],
      child: const ConfiguredApp(home: NotesListPage()),
    );

    // 3. Сценарии: имя → Size + Brightness
    final scenarios = {
      'phone_light': (
        size: const ui.Size(390, 844),
        brightness: Brightness.light,
      ),
      'tablet_landscape': (
        size: const ui.Size(1024, 768),
        brightness: Brightness.light,
      ),
      'phone_dark': (
        size: const ui.Size(390, 844),
        brightness: Brightness.dark,
      ),
    };

    for (final entry in scenarios.entries) {
      final name = entry.key;
      final size = entry.value.size;
      final brightness = entry.value.brightness;

      // 3.1 задаём «экран»
      await tester.binding.setSurfaceSize(size);

      // 3.2 рендер
      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(
            size: size,
            devicePixelRatio: 1,
            padding: EdgeInsets.zero,
            viewPadding: EdgeInsets.zero,
            viewInsets: EdgeInsets.zero,
            platformBrightness: brightness,
          ),
          child: scope,
        ),
      );
      await tester.pumpAndSettle();

      // 3.3 сравнение с golden
      await expectLater(
        find.byType(NotesListPage),
        matchesGoldenFile('success/notes_list_$name.png'),
      );
    }
  });
}
