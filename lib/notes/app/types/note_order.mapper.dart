// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'note_order.dart';

class NoteOrderMapper extends ClassMapperBase<NoteOrder> {
  NoteOrderMapper._();

  static NoteOrderMapper? _instance;
  static NoteOrderMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NoteOrderMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'NoteOrder';

  static NoteSortField _$field(NoteOrder v) => v.field;
  static const Field<NoteOrder, NoteSortField> _f$field = Field('field', _$field);
  static SortDirection _$direction(NoteOrder v) => v.direction;
  static const Field<NoteOrder, SortDirection> _f$direction = Field('direction', _$direction);

  @override
  final MappableFields<NoteOrder> fields = const {#field: _f$field, #direction: _f$direction};

  static NoteOrder _instantiate(DecodingData data) {
    return NoteOrder(field: data.dec(_f$field), direction: data.dec(_f$direction));
  }

  @override
  final Function instantiate = _instantiate;

  static NoteOrder fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NoteOrder>(map);
  }

  static NoteOrder fromJson(String json) {
    return ensureInitialized().decodeJson<NoteOrder>(json);
  }
}

mixin NoteOrderMappable {
  String toJson() {
    return NoteOrderMapper.ensureInitialized().encodeJson<NoteOrder>(this as NoteOrder);
  }

  Map<String, dynamic> toMap() {
    return NoteOrderMapper.ensureInitialized().encodeMap<NoteOrder>(this as NoteOrder);
  }

  NoteOrderCopyWith<NoteOrder, NoteOrder, NoteOrder> get copyWith =>
      _NoteOrderCopyWithImpl<NoteOrder, NoteOrder>(this as NoteOrder, $identity, $identity);
  @override
  String toString() {
    return NoteOrderMapper.ensureInitialized().stringifyValue(this as NoteOrder);
  }

  @override
  bool operator ==(Object other) {
    return NoteOrderMapper.ensureInitialized().equalsValue(this as NoteOrder, other);
  }

  @override
  int get hashCode {
    return NoteOrderMapper.ensureInitialized().hashValue(this as NoteOrder);
  }
}

extension NoteOrderValueCopy<$R, $Out> on ObjectCopyWith<$R, NoteOrder, $Out> {
  NoteOrderCopyWith<$R, NoteOrder, $Out> get $asNoteOrder =>
      $base.as((v, t, t2) => _NoteOrderCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class NoteOrderCopyWith<$R, $In extends NoteOrder, $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({NoteSortField? field, SortDirection? direction});
  NoteOrderCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NoteOrderCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, NoteOrder, $Out>
    implements NoteOrderCopyWith<$R, NoteOrder, $Out> {
  _NoteOrderCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NoteOrder> $mapper = NoteOrderMapper.ensureInitialized();
  @override
  $R call({NoteSortField? field, SortDirection? direction}) =>
      $apply(FieldCopyWithData({if (field != null) #field: field, if (direction != null) #direction: direction}));
  @override
  NoteOrder $make(CopyWithData data) =>
      NoteOrder(field: data.get(#field, or: $value.field), direction: data.get(#direction, or: $value.direction));

  @override
  NoteOrderCopyWith<$R2, NoteOrder, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _NoteOrderCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
