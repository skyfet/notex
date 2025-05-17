import 'package:flutter/material.dart'
    show MediaQuery, MediaQueryData, Scaffold, Size, ThemeMode;
import 'package:flutter_test/flutter_test.dart';

import 'package:notex/notes/presentation/list/note_tile.dart';
import 'package:notex/notex_app.dart';

import '../mocks.dart';
import 'configure_golden.dart';

void main() {
  initGoldens();

  testWidgets('NoteTile — dark', (tester) async {
    final note = fakeNote(
      title: 'Hello my dark friend',
      content: 'This NoteTile must be beauty!',
    );

    // --- LIGHT ---
    await tester.binding.setSurfaceSize(const Size(400, 82));

    await tester.pumpWidget(
      ConfiguredApp(
        themeMode: ThemeMode.dark,
        home: Scaffold(body: NoteTile(note: note, onTap: () {})),
      ),
    );
    await expectLater(
      find.byType(NoteTile),
      matchesGoldenFile('success/note_tile_dark.png'),
    );
  });

  testWidgets('NoteTile — light', (tester) async {
    final note = fakeNote(
      title: 'Hello my light friend',
      content: 'This NoteTile must be beauty!',
    );

    // --- LIGHT ---
    await tester.binding.setSurfaceSize(const Size(400, 82));

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(highContrast: false),
        child: ConfiguredApp(
          themeMode: ThemeMode.light,
          home: Scaffold(body: NoteTile(note: note, onTap: () {})),
        ),
      ),
    );
    await expectLater(
      find.byType(NoteTile),
      matchesGoldenFile('success/note_tile_light.png'),
    );
  });
}
