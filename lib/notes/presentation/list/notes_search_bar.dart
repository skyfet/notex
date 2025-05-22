import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotesSearchBar extends ConsumerStatefulWidget {
  const NotesSearchBar({required this.onQuery, super.key, this.hint = 'Поиск заметок'});

  final ValueChanged<String> onQuery;
  final String hint;

  @override
  ConsumerState<NotesSearchBar> createState() => _NotesSearchBarState();
}

class _NotesSearchBarState extends ConsumerState<NotesSearchBar> {
  late final SearchController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = SearchController();
    _controller.addListener(_onTextChanged);

    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    widget.onQuery(_controller.text);
  }

  @override
  Widget build(BuildContext context) => SearchBar(
    onTapOutside: (event) => _focusNode.unfocus(),
    focusNode: _focusNode,
    controller: _controller,
    hintText: widget.hint,
    onSubmitted: (v) => widget.onQuery(v),
    leading: const Icon(Icons.search),
    trailing: [
      if (_controller.text.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _controller.clear();
            widget.onQuery('');
          },
        ),
    ],
  );
}
