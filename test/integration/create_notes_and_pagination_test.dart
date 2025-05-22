import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notex/core/data/drift_database.dart';
import 'package:notex/notes/app/types/note_order.dart';
import 'package:notex/notes/app/usecases/create_note.dart';
import 'package:notex/notes/app/usecases/get_notes_paged.dart';
import 'package:notex/notes/data/repository/note_repository_impl.dart';
import 'package:notex/notes/domain/entities/note.dart';

class _MemoryDb extends AppDatabase {
  _MemoryDb() : super(_conn());
}

LazyDatabase _conn() => LazyDatabase(() async => NativeDatabase.memory());
void main() {
  late _MemoryDb db;
  late CreateNote create;
  late GetNotesPaged paged;

  setUp(() {
    db = _MemoryDb();
    final repo = NoteRepositoryImpl(db.notesDao);
    create = CreateNote(repo);
    paged = GetNotesPaged(repo);
  });

  tearDown(() => db.close());

  test('insert 100 notes and paginate by 20', () async {
    final faker = Faker();

    for (var i = 0; i < 100; i++) {
      await create(Note.create(title: faker.lorem.words(3).join(' '), content: faker.lorem.sentences(5).join(' ')));
    }

    var loaded = 0;
    while (true) {
      final chunk = await paged(offset: loaded, limit: 20, order: NoteOrder.byUpdatedDesc());
      loaded += chunk.length;
      if (chunk.length < 20) break;
    }
    expect(loaded, 100);
  });
}
