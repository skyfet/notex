import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notex/notes/domain/entities/note.dart';
import 'package:notex/notes/presentation/viewmodel/notes_list_viewmodel.dart';

import '../mocks.dart';

void main() {
  setUpAll(initTestDefault);

  late MockGetNotesPaged getPaged;
  late MockDeleteNote del;
  late MockCreateNote create;

  setUp(() {
    getPaged = MockGetNotesPaged();
    del = MockDeleteNote();
    create = MockCreateNote();

    when(
      () => getPaged(
        offset: any(named: 'offset'),
        limit: any(named: 'limit'),
        query: any(named: 'query'),
        order: any(named: 'order'),
      ),
    ).thenAnswer((_) async => [fakeNote()]);
  });

  NotesListViewModel createViewModel() => NotesListViewModel(
    getNotesPaged: getPaged,
    deleteNote: del,
    createNote: create,
    autoload: false, // вручную вызовем loadList()
  );

  /* ------------------------------------------------------------------ */

  test('init делает 1 запрос и снимает флаг загрузки', () async {
    final vm = createViewModel();
    await vm.loadList(); // один вызов

    verify(() => getPaged(offset: 0, limit: 100, query: '', order: any(named: 'order'))).called(1);

    expect(vm.state.isLoading, isFalse);
    expect(vm.state.notes, hasLength(1));
  });

  test('setQuery дебаунсит вызовы', () {
    FakeAsync().run((time) {
      createViewModel()
        ..loadList()
        ..setQuery('a')
        ..setQuery('ab');

      time.elapse(const Duration(milliseconds: 299));
      verifyNever(() => getPaged(query: 'ab', offset: 0, limit: 100, order: any(named: 'order')));

      time.elapse(const Duration(milliseconds: 2)); // после 301 мс
      verify(() => getPaged(query: 'ab', offset: 0, limit: 100, order: any(named: 'order'))).called(1);
    });
  });

  test('loadMore добавляет элементы и корректно выставляет hasMore', () async {
    when(
      () => getPaged(offset: 0, limit: 100, query: '', order: any(named: 'order')),
    ).thenAnswer((_) async => List.generate(100, (i) => fakeNote(id: i)));
    when(
      () => getPaged(offset: 100, limit: 100, query: '', order: any(named: 'order')),
    ).thenAnswer((_) async => List.generate(20, (i) => fakeNote(id: 100 + i)));

    final vm = createViewModel();
    await vm.loadList(); // первая страница
    await vm.loadMore(); // вторая страница

    expect(vm.state.notes.length, 120);
    expect(vm.state.hasMore, isFalse);
  });

  test('restore создаёт новую заметку без старого id', () async {
    final note = fakeNote(id: 43);
    when(() => getPaged(offset: 0, limit: 100, query: '', order: any(named: 'order'))).thenAnswer((_) async => [note]);

    when(() => del(43)).thenAnswer((_) async {});
    when(() => create(any<Note>())).thenAnswer((_) async {});

    final vm = createViewModel();
    await vm.loadList();

    await vm.delete(43);
    await vm.restore();

    final created = verify(() => create(captureAny<Note>())).captured.single as Note;
    expect(created.id, anyOf(isNull, equals(0)));
  });
}
