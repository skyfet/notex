import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notex/di/app_providers.dart';
import 'package:notex/notes/app/usecases/create_note.dart';
import 'package:notex/notes/app/usecases/delete_note.dart';
import 'package:notex/notes/app/usecases/get_notes_paged.dart';
import 'package:notex/notes/app/usecases/update_note.dart';
import 'package:notex/notes/data/datasources/notes_dao.dart';
import 'package:notex/notes/data/repository/note_repository_impl.dart';
import 'package:notex/notes/domain/repositories/note_repository.dart';

// use‑cases
final createNoteProvider = Provider<CreateNote>((ref) {
  final repo = ref.watch(noteRepositoryProvider);
  return CreateNote(repo);
});
final updateNoteProvider = Provider<UpdateNote>((ref) {
  final repo = ref.watch(noteRepositoryProvider);
  return UpdateNote(repo);
});
final deleteNoteProvider = Provider<DeleteNote>((ref) {
  final repo = ref.watch(noteRepositoryProvider);
  return DeleteNote(repo);
});
final getNotesPagedProvider = Provider<GetNotesPaged>((ref) {
  final repo = ref.watch(noteRepositoryProvider);
  return GetNotesPaged(repo);
});

// репозиторий
final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  final dao = ref.watch(notesDaoProvider);
  return NoteRepositoryImpl(dao);
});

// DAO
final notesDaoProvider = Provider<NotesDao>((ref) => ref.watch(appDatabaseProvider).notesDao);
