// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'green_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GreenModel {
  String get option; // "planted_tree", "lights_off", etc
  List<double> get location;

  /// Create a copy of GreenModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GreenModelCopyWith<GreenModel> get copyWith =>
      _$GreenModelCopyWithImpl<GreenModel>(this as GreenModel, _$identity);

  /// Serializes this GreenModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GreenModel &&
            (identical(other.option, option) || other.option == option) &&
            const DeepCollectionEquality().equals(other.location, location));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, option, const DeepCollectionEquality().hash(location));

  @override
  String toString() {
    return 'GreenModel(option: $option, location: $location)';
  }
}

/// @nodoc
abstract mixin class $GreenModelCopyWith<$Res> {
  factory $GreenModelCopyWith(
          GreenModel value, $Res Function(GreenModel) _then) =
      _$GreenModelCopyWithImpl;
  @useResult
  $Res call({String option, List<double> location});
}

/// @nodoc
class _$GreenModelCopyWithImpl<$Res> implements $GreenModelCopyWith<$Res> {
  _$GreenModelCopyWithImpl(this._self, this._then);

  final GreenModel _self;
  final $Res Function(GreenModel) _then;

  /// Create a copy of GreenModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? option = null,
    Object? location = null,
  }) {
    return _then(_self.copyWith(
      option: null == option
          ? _self.option
          : option // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _GreenModel implements GreenModel {
  const _GreenModel(
      {required this.option, required final List<double> location})
      : _location = location;
  factory _GreenModel.fromJson(Map<String, dynamic> json) =>
      _$GreenModelFromJson(json);

  @override
  final String option;
// "planted_tree", "lights_off", etc
  final List<double> _location;
// "planted_tree", "lights_off", etc
  @override
  List<double> get location {
    if (_location is EqualUnmodifiableListView) return _location;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_location);
  }

    GreenEntity toEntity() {
    return GreenEntity(
      option: option,
      location: location,
    );
  }

  ActionDTO toActionDTO() {
    return ActionDTO(
      actionType: 'green',
      payload: {
        'option': option,
        'location': location,
      },
      metadata: {},
    );
  }

  /// Create a copy of GreenModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GreenModelCopyWith<_GreenModel> get copyWith =>
      __$GreenModelCopyWithImpl<_GreenModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GreenModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GreenModel &&
            (identical(other.option, option) || other.option == option) &&
            const DeepCollectionEquality().equals(other._location, _location));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, option, const DeepCollectionEquality().hash(_location));

  @override
  String toString() {
    return 'GreenModel(option: $option, location: $location)';
  }
}

/// @nodoc
abstract mixin class _$GreenModelCopyWith<$Res>
    implements $GreenModelCopyWith<$Res> {
  factory _$GreenModelCopyWith(
          _GreenModel value, $Res Function(_GreenModel) _then) =
      __$GreenModelCopyWithImpl;
  @override
  @useResult
  $Res call({String option, List<double> location});
}

/// @nodoc
class __$GreenModelCopyWithImpl<$Res> implements _$GreenModelCopyWith<$Res> {
  __$GreenModelCopyWithImpl(this._self, this._then);

  final _GreenModel _self;
  final $Res Function(_GreenModel) _then;

  /// Create a copy of GreenModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? option = null,
    Object? location = null,
  }) {
    return _then(_GreenModel(
      option: null == option
          ? _self.option
          : option // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self._location
          : location // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

// dart format on
