import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart' show TestWidgetsFlutterBinding;
import 'package:mocktail/mocktail.dart';
import 'package:notex/di/localizations.dart';
import 'package:notex/notes/app/types/note_order.dart';
import 'package:notex/notes/app/usecases/create_note.dart';
import 'package:notex/notes/app/usecases/delete_note.dart';
import 'package:notex/notes/app/usecases/get_notes_paged.dart';
import 'package:notex/notes/domain/entities/note.dart';

class MockGetNotesPaged extends Mock implements GetNotesPaged {}

class MockDeleteNote extends Mock implements DeleteNote {}

class MockCreateNote extends Mock implements CreateNote {}

Note fakeNote({
  int id = 1,
  String? title,
  String? content,
  DateTime? created,
  DateTime? updated,
}) {
  final now = DateTime.now();
  return Note(
    id: id,
    title: title ?? Faker().lorem.words(4).join(' '),
    content: content ?? Faker().lorem.sentences(3).join(' '),
    createdAt: created ?? now,
    updatedAt: updated ?? now,
  );
}

Future<void> initTestDefault() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  registerFallbackValue(NoteOrder.byUpdatedDesc());
  registerFallbackValue(fakeNote());

  await initLocale();
}
