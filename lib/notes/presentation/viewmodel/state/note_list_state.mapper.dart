// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'note_list_state.dart';

class NotesListStateMapper extends ClassMapperBase<NotesListState> {
  NotesListStateMapper._();

  static NotesListStateMapper? _instance;
  static NotesListStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NotesListStateMapper._());
      NoteMapper.ensureInitialized();
      NoteOrderMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NotesListState';

  static List<Note> _$notes(NotesListState v) => v.notes;
  static const Field<NotesListState, List<Note>> _f$notes =
      Field('notes', _$notes, opt: true, def: const []);
  static String _$query(NotesListState v) => v.query;
  static const Field<NotesListState, String> _f$query =
      Field('query', _$query, opt: true, def: '');
  static NoteOrder _$order(NotesListState v) => v.order;
  static const Field<NotesListState, NoteOrder> _f$order = Field(
      'order', _$order,
      opt: true,
      def: const NoteOrder(
          field: NoteSortField.updatedAt, direction: SortDirection.desc));
  static bool _$isInitialLoading(NotesListState v) => v.isInitialLoading;
  static const Field<NotesListState, bool> _f$isInitialLoading =
      Field('isInitialLoading', _$isInitialLoading, opt: true, def: true);
  static bool _$isLoading(NotesListState v) => v.isLoading;
  static const Field<NotesListState, bool> _f$isLoading =
      Field('isLoading', _$isLoading, opt: true, def: false);
  static bool _$isLoadingMore(NotesListState v) => v.isLoadingMore;
  static const Field<NotesListState, bool> _f$isLoadingMore =
      Field('isLoadingMore', _$isLoadingMore, opt: true, def: false);
  static bool _$hasMore(NotesListState v) => v.hasMore;
  static const Field<NotesListState, bool> _f$hasMore =
      Field('hasMore', _$hasMore, opt: true, def: true);
  static String? _$error(NotesListState v) => v.error;
  static const Field<NotesListState, String> _f$error =
      Field('error', _$error, opt: true);

  @override
  final MappableFields<NotesListState> fields = const {
    #notes: _f$notes,
    #query: _f$query,
    #order: _f$order,
    #isInitialLoading: _f$isInitialLoading,
    #isLoading: _f$isLoading,
    #isLoadingMore: _f$isLoadingMore,
    #hasMore: _f$hasMore,
    #error: _f$error,
  };

  static NotesListState _instantiate(DecodingData data) {
    return NotesListState(
        notes: data.dec(_f$notes),
        query: data.dec(_f$query),
        order: data.dec(_f$order),
        isInitialLoading: data.dec(_f$isInitialLoading),
        isLoading: data.dec(_f$isLoading),
        isLoadingMore: data.dec(_f$isLoadingMore),
        hasMore: data.dec(_f$hasMore),
        error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static NotesListState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NotesListState>(map);
  }

  static NotesListState fromJson(String json) {
    return ensureInitialized().decodeJson<NotesListState>(json);
  }
}

mixin NotesListStateMappable {
  String toJson() {
    return NotesListStateMapper.ensureInitialized()
        .encodeJson<NotesListState>(this as NotesListState);
  }

  Map<String, dynamic> toMap() {
    return NotesListStateMapper.ensureInitialized()
        .encodeMap<NotesListState>(this as NotesListState);
  }

  NotesListStateCopyWith<NotesListState, NotesListState, NotesListState>
      get copyWith =>
          _NotesListStateCopyWithImpl<NotesListState, NotesListState>(
              this as NotesListState, $identity, $identity);
  @override
  String toString() {
    return NotesListStateMapper.ensureInitialized()
        .stringifyValue(this as NotesListState);
  }

  @override
  bool operator ==(Object other) {
    return NotesListStateMapper.ensureInitialized()
        .equalsValue(this as NotesListState, other);
  }

  @override
  int get hashCode {
    return NotesListStateMapper.ensureInitialized()
        .hashValue(this as NotesListState);
  }
}

extension NotesListStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NotesListState, $Out> {
  NotesListStateCopyWith<$R, NotesListState, $Out> get $asNotesListState =>
      $base.as((v, t, t2) => _NotesListStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class NotesListStateCopyWith<$R, $In extends NotesListState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Note, NoteCopyWith<$R, Note, Note>> get notes;
  NoteOrderCopyWith<$R, NoteOrder, NoteOrder> get order;
  $R call(
      {List<Note>? notes,
      String? query,
      NoteOrder? order,
      bool? isInitialLoading,
      bool? isLoading,
      bool? isLoadingMore,
      bool? hasMore,
      String? error});
  NotesListStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NotesListStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NotesListState, $Out>
    implements NotesListStateCopyWith<$R, NotesListState, $Out> {
  _NotesListStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NotesListState> $mapper =
      NotesListStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Note, NoteCopyWith<$R, Note, Note>> get notes =>
      ListCopyWith(
          $value.notes, (v, t) => v.copyWith.$chain(t), (v) => call(notes: v));
  @override
  NoteOrderCopyWith<$R, NoteOrder, NoteOrder> get order =>
      $value.order.copyWith.$chain((v) => call(order: v));
  @override
  $R call(
          {List<Note>? notes,
          String? query,
          NoteOrder? order,
          bool? isInitialLoading,
          bool? isLoading,
          bool? isLoadingMore,
          bool? hasMore,
          Object? error = $none}) =>
      $apply(FieldCopyWithData({
        if (notes != null) #notes: notes,
        if (query != null) #query: query,
        if (order != null) #order: order,
        if (isInitialLoading != null) #isInitialLoading: isInitialLoading,
        if (isLoading != null) #isLoading: isLoading,
        if (isLoadingMore != null) #isLoadingMore: isLoadingMore,
        if (hasMore != null) #hasMore: hasMore,
        if (error != $none) #error: error
      }));
  @override
  NotesListState $make(CopyWithData data) => NotesListState(
      notes: data.get(#notes, or: $value.notes),
      query: data.get(#query, or: $value.query),
      order: data.get(#order, or: $value.order),
      isInitialLoading:
          data.get(#isInitialLoading, or: $value.isInitialLoading),
      isLoading: data.get(#isLoading, or: $value.isLoading),
      isLoadingMore: data.get(#isLoadingMore, or: $value.isLoadingMore),
      hasMore: data.get(#hasMore, or: $value.hasMore),
      error: data.get(#error, or: $value.error));

  @override
  NotesListStateCopyWith<$R2, NotesListState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NotesListStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
