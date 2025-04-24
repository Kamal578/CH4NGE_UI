// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActionDTO {
  String get actionType;
  Map<String, dynamic> get payload;
  Map<String, dynamic> get metadata;

  /// Create a copy of ActionDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActionDTOCopyWith<ActionDTO> get copyWith =>
      _$ActionDTOCopyWithImpl<ActionDTO>(this as ActionDTO, _$identity);

  /// Serializes this ActionDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActionDTO &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            const DeepCollectionEquality().equals(other.payload, payload) &&
            const DeepCollectionEquality().equals(other.metadata, metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      actionType,
      const DeepCollectionEquality().hash(payload),
      const DeepCollectionEquality().hash(metadata));

  @override
  String toString() {
    return 'ActionDTO(actionType: $actionType, payload: $payload, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class $ActionDTOCopyWith<$Res> {
  factory $ActionDTOCopyWith(ActionDTO value, $Res Function(ActionDTO) _then) =
      _$ActionDTOCopyWithImpl;
  @useResult
  $Res call(
      {String actionType,
      Map<String, dynamic> payload,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$ActionDTOCopyWithImpl<$Res> implements $ActionDTOCopyWith<$Res> {
  _$ActionDTOCopyWithImpl(this._self, this._then);

  final ActionDTO _self;
  final $Res Function(ActionDTO) _then;

  /// Create a copy of ActionDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? payload = null,
    Object? metadata = null,
  }) {
    return _then(_self.copyWith(
      actionType: null == actionType
          ? _self.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      metadata: null == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ActionDTO implements ActionDTO {
  const _ActionDTO(
      {required this.actionType,
      required final Map<String, dynamic> payload,
      required final Map<String, dynamic> metadata})
      : _payload = payload,
        _metadata = metadata;
  factory _ActionDTO.fromJson(Map<String, dynamic> json) =>
      _$ActionDTOFromJson(json);

  @override
  final String actionType;
  final Map<String, dynamic> _payload;
  @override
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  final Map<String, dynamic> _metadata;
  @override
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  /// Create a copy of ActionDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ActionDTOCopyWith<_ActionDTO> get copyWith =>
      __$ActionDTOCopyWithImpl<_ActionDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ActionDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ActionDTO &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            const DeepCollectionEquality().equals(other._payload, _payload) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      actionType,
      const DeepCollectionEquality().hash(_payload),
      const DeepCollectionEquality().hash(_metadata));

  @override
  String toString() {
    return 'ActionDTO(actionType: $actionType, payload: $payload, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class _$ActionDTOCopyWith<$Res>
    implements $ActionDTOCopyWith<$Res> {
  factory _$ActionDTOCopyWith(
          _ActionDTO value, $Res Function(_ActionDTO) _then) =
      __$ActionDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String actionType,
      Map<String, dynamic> payload,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$ActionDTOCopyWithImpl<$Res> implements _$ActionDTOCopyWith<$Res> {
  __$ActionDTOCopyWithImpl(this._self, this._then);

  final _ActionDTO _self;
  final $Res Function(_ActionDTO) _then;

  /// Create a copy of ActionDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? actionType = null,
    Object? payload = null,
    Object? metadata = null,
  }) {
    return _then(_ActionDTO(
      actionType: null == actionType
          ? _self.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      metadata: null == metadata
          ? _self._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

// dart format on
