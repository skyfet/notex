// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'note_form_state.dart';

class NoteFormStateMapper extends ClassMapperBase<NoteFormState> {
  NoteFormStateMapper._();

  static NoteFormStateMapper? _instance;
  static NoteFormStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NoteFormStateMapper._());
      NoteMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NoteFormState';

  static String _$title(NoteFormState v) => v.title;
  static const Field<NoteFormState, String> _f$title = Field('title', _$title, opt: true, def: '');
  static String _$content(NoteFormState v) => v.content;
  static const Field<NoteFormState, String> _f$content = Field('content', _$content, opt: true, def: '');
  static Note? _$existing(NoteFormState v) => v.existing;
  static const Field<NoteFormState, Note> _f$existing = Field('existing', _$existing, opt: true);
  static ValidationException? _$error(NoteFormState v) => v.error;
  static const Field<NoteFormState, ValidationException> _f$error = Field('error', _$error, opt: true);

  @override
  final MappableFields<NoteFormState> fields = const {
    #title: _f$title,
    #content: _f$content,
    #existing: _f$existing,
    #error: _f$error,
  };

  static NoteFormState _instantiate(DecodingData data) {
    return NoteFormState(
      title: data.dec(_f$title),
      content: data.dec(_f$content),
      existing: data.dec(_f$existing),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static NoteFormState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NoteFormState>(map);
  }

  static NoteFormState fromJson(String json) {
    return ensureInitialized().decodeJson<NoteFormState>(json);
  }
}

mixin NoteFormStateMappable {
  String toJson() {
    return NoteFormStateMapper.ensureInitialized().encodeJson<NoteFormState>(this as NoteFormState);
  }

  Map<String, dynamic> toMap() {
    return NoteFormStateMapper.ensureInitialized().encodeMap<NoteFormState>(this as NoteFormState);
  }

  NoteFormStateCopyWith<NoteFormState, NoteFormState, NoteFormState> get copyWith =>
      _NoteFormStateCopyWithImpl<NoteFormState, NoteFormState>(this as NoteFormState, $identity, $identity);
  @override
  String toString() {
    return NoteFormStateMapper.ensureInitialized().stringifyValue(this as NoteFormState);
  }

  @override
  bool operator ==(Object other) {
    return NoteFormStateMapper.ensureInitialized().equalsValue(this as NoteFormState, other);
  }

  @override
  int get hashCode {
    return NoteFormStateMapper.ensureInitialized().hashValue(this as NoteFormState);
  }
}

extension NoteFormStateValueCopy<$R, $Out> on ObjectCopyWith<$R, NoteFormState, $Out> {
  NoteFormStateCopyWith<$R, NoteFormState, $Out> get $asNoteFormState =>
      $base.as((v, t, t2) => _NoteFormStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class NoteFormStateCopyWith<$R, $In extends NoteFormState, $Out> implements ClassCopyWith<$R, $In, $Out> {
  NoteCopyWith<$R, Note, Note>? get existing;
  $R call({String? title, String? content, Note? existing, ValidationException? error});
  NoteFormStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NoteFormStateCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, NoteFormState, $Out>
    implements NoteFormStateCopyWith<$R, NoteFormState, $Out> {
  _NoteFormStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NoteFormState> $mapper = NoteFormStateMapper.ensureInitialized();
  @override
  NoteCopyWith<$R, Note, Note>? get existing => $value.existing?.copyWith.$chain((v) => call(existing: v));
  @override
  $R call({String? title, String? content, Object? existing = $none, Object? error = $none}) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (content != null) #content: content,
      if (existing != $none) #existing: existing,
      if (error != $none) #error: error,
    }),
  );
  @override
  NoteFormState $make(CopyWithData data) => NoteFormState(
    title: data.get(#title, or: $value.title),
    content: data.get(#content, or: $value.content),
    existing: data.get(#existing, or: $value.existing),
    error: data.get(#error, or: $value.error),
  );

  @override
  NoteFormStateCopyWith<$R2, NoteFormState, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _NoteFormStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
