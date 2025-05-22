import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notex/core/exceptions/validation_exception.dart';
import 'package:notex/di/notes_providers.dart';
import 'package:notex/notes/app/usecases/create_note.dart';
import 'package:notex/notes/app/usecases/update_note.dart';
import 'package:notex/notes/domain/entities/note.dart';
import 'package:notex/notes/presentation/viewmodel/state/note_form_state.dart';

/// Provider‑family: создаёт VM с уже заполненным начальными данными
final noteFormViewModelProvider = StateNotifierProvider.autoDispose.family<NoteFormViewModel, NoteFormState, Note?>(
  (ref, note) => NoteFormViewModel(
    createNote: ref.read(createNoteProvider),
    updateNote: ref.read(updateNoteProvider),
    initialNote: note,
  ),
);

class NoteFormViewModel extends StateNotifier<NoteFormState> {
  NoteFormViewModel({required this.createNote, required this.updateNote, Note? initialNote})
    : super(
        initialNote == null
            ? const NoteFormState()
            : NoteFormState(existing: initialNote, title: initialNote.title, content: initialNote.content),
      );
  final CreateNote createNote;
  final UpdateNote updateNote;

  void setTitle(String v) => state = state.copyWith(title: v, error: null);
  void setContent(String v) => state = state.copyWith(content: v, error: null);

  bool get isValid => state.title.trim().isNotEmpty;

  Future<void> submit() async {
    try {
      if (state.existing == null) {
        await createNote(Note.create(title: state.title, content: state.content));
      } else {
        await updateNote(state.existing!.copyWith(title: state.title, content: state.content));
      }
      state = state.copyWith(error: null);
    } on ValidationException catch (e) {
      state = state.copyWith(error: e);
    }
  }
}
