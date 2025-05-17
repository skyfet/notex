import 'dart:async';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notex/di/notes_providers.dart';
import 'package:notex/notes/app/types/note_order.dart';
import 'package:notex/notes/app/usecases/create_note.dart';
import 'package:notex/notes/app/usecases/delete_note.dart';
import 'package:notex/notes/app/usecases/get_notes_paged.dart';
import 'package:notex/notes/domain/entities/note.dart';
import 'package:notex/notes/presentation/viewmodel/state/note_list_state.dart';

final notesListViewModelProvider =
    StateNotifierProvider<NotesListViewModel, NotesListState>(
      (ref) => NotesListViewModel(
        getNotesPaged: ref.read(getNotesPagedProvider),
        deleteNote: ref.read(deleteNoteProvider),
        createNote: ref.read(createNoteProvider),
      ),
    );

class NotesListViewModel extends StateNotifier<NotesListState> {
  final GetNotesPaged getNotesPaged;
  final DeleteNote deleteNote;
  final CreateNote createNote;

  static const _pageSize = 100;

  /// Инкремент для отсечения устаревших результатов.
  int _requestId = 0;

  Timer? _debounce;
  Note? _lastDeleted;

  NotesListViewModel({
    required this.getNotesPaged,
    required this.deleteNote,
    required this.createNote,
    bool autoload = true,
  }) : super(const NotesListState()) {
    if (autoload) {
      loadList(true);
    }
  }

  Future<void> generateFake(int count) async {
    if (!kDebugMode) return;

    final faker = Faker();
    final rnd = Random();
    for (var i = 0; i < count; i++) {
      await createNote(
        Note.create(
          title: faker.lorem.words(rnd.nextInt(8) + 3).join(' '),
          content: faker.lorem.sentences(rnd.nextInt(64)).join(' '),
        ),
      );
    }
    await refresh();
  }

  Future<void> loadList([bool initial = false]) async {
    final myId = ++_requestId;

    state = state.copyWith(
      isInitialLoading: initial,
      isLoading: true,
      isLoadingMore: false,
      hasMore: true,
      error: null,
    );

    try {
      final notes = await getNotesPaged(
        offset: 0,
        limit: _pageSize,
        query: state.query,
        order: state.order,
      );
      if (myId != _requestId) return; // результат устарел, не обновляем стейт
      // if (kDebugMode) await Future.delayed(const Duration(milliseconds: 400));

      state = state.copyWith(
        notes: notes,
        isLoading: false,
        isInitialLoading: false,
        hasMore: notes.length >= _pageSize,
      );
    } catch (e) {
      if (myId != _requestId) return;
      state = state.copyWith(
        isLoading: false,
        isInitialLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final next = await getNotesPaged(
        offset: state.notes.length,
        limit: _pageSize,
        query: state.query,
        order: state.order,
      );

      // if (kDebugMode) await Future.delayed(const Duration(milliseconds: 400));

      final notes = [...state.notes, ...next];
      state = state.copyWith(
        notes: notes,
        isLoadingMore: false,
        hasMore: next.length >= _pageSize,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  void setQuery(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      state = state.copyWith(query: query);
      loadList();
    });
  }

  void setOrder(NoteOrder order) {
    state = state.copyWith(order: order);
    loadList();
  }

  Future<void> delete(int id) async {
    final note = state.notes.firstWhere((n) => n.id == id);
    _lastDeleted = note;

    await deleteNote(id);
    loadList();
  }

  Future<void> restore() async {
    final note = _lastDeleted;
    if (note == null) return;
    _lastDeleted = null;

    // создаём новую заметку с теми же данными
    await createNote(Note.create(title: note.title, content: note.content));
    loadList();
  }

  Future<void> refresh() => loadList();

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
