import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notex/notes/presentation/note_form_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('✓ button disabled until title typed', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: NoteFormPage())),
    );

    final saveBtn = find.widgetWithIcon(IconButton, Icons.check);
    expect(
      tester.widget<IconButton>(saveBtn).onPressed,
      isNull,
      reason: 'должна быть заблокирована при пустом заголовке',
    );

    await tester.enterText(find.byType(TextFormField).first, 'Test');
    await tester.pump();

    expect(
      tester.widget<IconButton>(saveBtn).onPressed,
      isNotNull,
      reason: 'после ввода заголовка кнопка активируется',
    );
  });
}
