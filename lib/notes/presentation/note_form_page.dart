import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notex/notes/domain/entities/note.dart';
import 'package:notex/notes/presentation/viewmodel/note_form_viewmodel.dart';

class NoteFormPage extends ConsumerStatefulWidget {
  final Note? note;
  const NoteFormPage({super.key, this.note});

  @override
  ConsumerState<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends ConsumerState<NoteFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _contentCtrl;

  @override
  void initState() {
    super.initState();
    final initState = ref.read(noteFormViewModelProvider(widget.note));

    _titleCtrl = TextEditingController(text: initState.title);
    _contentCtrl = TextEditingController(text: initState.content);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = noteFormViewModelProvider(widget.note);
    final state = ref.watch(provider);
    final vm = ref.read(provider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(state.isEditing ? 'Редактировать' : 'Создать заметку'),
        actions: [
          IconButton(
            tooltip: 'Сохранить',
            icon: const Icon(Icons.check),
            onPressed:
                vm.isValid
                    ? () async {
                      await vm.submit();
                      if (!context.mounted) return;
                      Navigator.of(context).pop(true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Сохранено')),
                      );
                    }
                    : null,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleCtrl,
                      onChanged: vm.setTitle,
                      decoration: InputDecoration(
                        labelText: 'Заголовок',
                        errorText: state.error?.errorTextFor('title'),
                      ),
                      autofocus: !state.isEditing,
                    ),
                    const Divider(height: 32),
                    TextFormField(
                      controller: _contentCtrl,
                      onChanged: vm.setContent,
                      decoration: const InputDecoration(
                        labelText: 'Текст',
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 24,
                    ),
                    if (state.error?.errorTextFor('content') != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            state.error!.errorTextFor('content')!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
