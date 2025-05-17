import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notex/notes/app/usecases/create_note.dart';
import 'package:notex/notes/domain/entities/note.dart';
import 'package:notex/notes/domain/repositories/note_repository.dart';

class _MockRepo extends Mock implements NoteRepository {}

class _FakeNote extends Fake implements Note {}

void main() {
  late _MockRepo repo;
  late CreateNote useCase;

  setUpAll(() {
    registerFallbackValue(_FakeNote());
  });

  setUp(() {
    repo = _MockRepo();
    useCase = CreateNote(repo);
  });

  test('valid note triggers repo.createNote() once', () async {
    when(() => repo.createNote(any())).thenAnswer((_) async {});
    final note = Note.create(title: 'Hello', content: 'World');

    await useCase(note);

    verify(() => repo.createNote(note)).called(1);
  });

  test('invalid note throws ValidationException and skips repo', () async {
    final bad = Note.create(title: '', content: '');
    expect(() => useCase(bad), throwsException);
    verifyNever(() => repo.createNote(any()));
  });
}
