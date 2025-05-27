// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transportation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransportationModel {
  String get option;
  String get vehicle;
  List<double> get location;
  double get distance;
  double get duration;
  String get distanceUnit;
  String get durationUnit;
  String? get fuelType;
  double? get fuelConsumption;
  String? get fuelConsumptionUnit;
  int? get numberOfPassengers;
  String? get publicTransportType;

  /// Create a copy of TransportationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransportationModelCopyWith<TransportationModel> get copyWith =>
      _$TransportationModelCopyWithImpl<TransportationModel>(
          this as TransportationModel, _$identity);

  /// Serializes this TransportationModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransportationModel &&
            (identical(other.option, option) || other.option == option) &&
            (identical(other.vehicle, vehicle) || other.vehicle == vehicle) &&
            const DeepCollectionEquality().equals(other.location, location) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.distanceUnit, distanceUnit) ||
                other.distanceUnit == distanceUnit) &&
            (identical(other.durationUnit, durationUnit) ||
                other.durationUnit == durationUnit) &&
            (identical(other.fuelType, fuelType) ||
                other.fuelType == fuelType) &&
            (identical(other.fuelConsumption, fuelConsumption) ||
                other.fuelConsumption == fuelConsumption) &&
            (identical(other.fuelConsumptionUnit, fuelConsumptionUnit) ||
                other.fuelConsumptionUnit == fuelConsumptionUnit) &&
            (identical(other.numberOfPassengers, numberOfPassengers) ||
                other.numberOfPassengers == numberOfPassengers) &&
            (identical(other.publicTransportType, publicTransportType) ||
                other.publicTransportType == publicTransportType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      option,
      vehicle,
      const DeepCollectionEquality().hash(location),
      distance,
      duration,
      distanceUnit,
      durationUnit,
      fuelType,
      fuelConsumption,
      fuelConsumptionUnit,
      numberOfPassengers,
      publicTransportType);

  @override
  String toString() {
    return 'TransportationModel(option: $option, vehicle: $vehicle, location: $location, distance: $distance, duration: $duration, distanceUnit: $distanceUnit, durationUnit: $durationUnit, fuelType: $fuelType, fuelConsumption: $fuelConsumption, fuelConsumptionUnit: $fuelConsumptionUnit, numberOfPassengers: $numberOfPassengers, publicTransportType: $publicTransportType)';
  }
}

/// @nodoc
abstract mixin class $TransportationModelCopyWith<$Res> {
  factory $TransportationModelCopyWith(
          TransportationModel value, $Res Function(TransportationModel) _then) =
      _$TransportationModelCopyWithImpl;
  @useResult
  $Res call(
      {String option,
      String vehicle,
      List<double> location,
      double distance,
      double duration,
      String distanceUnit,
      String durationUnit,
      String? fuelType,
      double? fuelConsumption,
      String? fuelConsumptionUnit,
      int? numberOfPassengers,
      String? publicTransportType});
}

/// @nodoc
class _$TransportationModelCopyWithImpl<$Res>
    implements $TransportationModelCopyWith<$Res> {
  _$TransportationModelCopyWithImpl(this._self, this._then);

  final TransportationModel _self;
  final $Res Function(TransportationModel) _then;

  /// Create a copy of TransportationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? option = null,
    Object? vehicle = null,
    Object? location = null,
    Object? distance = null,
    Object? duration = null,
    Object? distanceUnit = null,
    Object? durationUnit = null,
    Object? fuelType = freezed,
    Object? fuelConsumption = freezed,
    Object? fuelConsumptionUnit = freezed,
    Object? numberOfPassengers = freezed,
    Object? publicTransportType = freezed,
  }) {
    return _then(_self.copyWith(
      option: null == option
          ? _self.option
          : option // ignore: cast_nullable_to_non_nullable
              as String,
      vehicle: null == vehicle
          ? _self.vehicle
          : vehicle // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as List<double>,
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      distanceUnit: null == distanceUnit
          ? _self.distanceUnit
          : distanceUnit // ignore: cast_nullable_to_non_nullable
              as String,
      durationUnit: null == durationUnit
          ? _self.durationUnit
          : durationUnit // ignore: cast_nullable_to_non_nullable
              as String,
      fuelType: freezed == fuelType
          ? _self.fuelType
          : fuelType // ignore: cast_nullable_to_non_nullable
              as String?,
      fuelConsumption: freezed == fuelConsumption
          ? _self.fuelConsumption
          : fuelConsumption // ignore: cast_nullable_to_non_nullable
              as double?,
      fuelConsumptionUnit: freezed == fuelConsumptionUnit
          ? _self.fuelConsumptionUnit
          : fuelConsumptionUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfPassengers: freezed == numberOfPassengers
          ? _self.numberOfPassengers
          : numberOfPassengers // ignore: cast_nullable_to_non_nullable
              as int?,
      publicTransportType: freezed == publicTransportType
          ? _self.publicTransportType
          : publicTransportType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TransportationModel implements TransportationModel {
  const _TransportationModel(
      {required this.option,
      required this.vehicle,
      required final List<double> location,
      required this.distance,
      required this.duration,
      required this.distanceUnit,
      required this.durationUnit,
      this.fuelType,
      this.fuelConsumption,
      this.fuelConsumptionUnit,
      this.numberOfPassengers,
      this.publicTransportType})
      : _location = location;
  factory _TransportationModel.fromJson(Map<String, dynamic> json) =>
      _$TransportationModelFromJson(json);

  @override
  final String option;
  @override
  final String vehicle;
  final List<double> _location;
  @override
  List<double> get location {
    if (_location is EqualUnmodifiableListView) return _location;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_location);
  }

  @override
  final double distance;
  @override
  final double duration;
  @override
  final String distanceUnit;
  @override
  final String durationUnit;
  @override
  final String? fuelType;
  @override
  final double? fuelConsumption;
  @override
  final String? fuelConsumptionUnit;
  @override
  final int? numberOfPassengers;
  @override
  final String? publicTransportType;

  // Convert to TransportationEntity
  TransportationEntity toEntity() {
    return TransportationEntity(
      option: option,
      vehicle: vehicle,
      location: location,
      distance: distance,
      duration: duration,
      distanceUnit: distanceUnit,
      durationUnit: durationUnit,
      fuelType: fuelType,
      fuelConsumption: fuelConsumption,
      fuelConsumptionUnit: fuelConsumptionUnit,
      numberOfPassengers: numberOfPassengers,
      publicTransportType: publicTransportType,
    );
  }

  // Convert to ActionDTO with all transportation-specific fields
  ActionDTO toActionDTO() {
    final Map<String, dynamic> payload = {
      'option': option,
      'vehicle': vehicle,
      'location': location,
      'distance': distance,
      'duration': duration,
      'distanceUnit': distanceUnit,
      'durationUnit': durationUnit,
    };

    // Add optional fields only if they are not null
    if (fuelType != null) payload['fuelType'] = fuelType;
    if (fuelConsumption != null) payload['fuelConsumption'] = fuelConsumption;
    if (fuelConsumptionUnit != null)
      payload['fuelConsumptionUnit'] = fuelConsumptionUnit;
    if (numberOfPassengers != null)
      payload['numberOfPassengers'] = numberOfPassengers;
    if (publicTransportType != null)
      payload['publicTransportType'] = publicTransportType;

    return ActionDTO(
      actionType: 'transportation',
      payload: payload,
      metadata: {
        'transportMode': option,
        'isEcoFriendly': toEntity().isEcoFriendly,
        'estimatedCO2Emissions': toEntity().estimatedCO2Emissions,
        'transportModeDisplay': toEntity().transportModeDisplay,
      },
    );
  }

  /// Create a copy of TransportationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TransportationModelCopyWith<_TransportationModel> get copyWith =>
      __$TransportationModelCopyWithImpl<_TransportationModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TransportationModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TransportationModel &&
            (identical(other.option, option) || other.option == option) &&
            (identical(other.vehicle, vehicle) || other.vehicle == vehicle) &&
            const DeepCollectionEquality().equals(other._location, _location) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.distanceUnit, distanceUnit) ||
                other.distanceUnit == distanceUnit) &&
            (identical(other.durationUnit, durationUnit) ||
                other.durationUnit == durationUnit) &&
            (identical(other.fuelType, fuelType) ||
                other.fuelType == fuelType) &&
            (identical(other.fuelConsumption, fuelConsumption) ||
                other.fuelConsumption == fuelConsumption) &&
            (identical(other.fuelConsumptionUnit, fuelConsumptionUnit) ||
                other.fuelConsumptionUnit == fuelConsumptionUnit) &&
            (identical(other.numberOfPassengers, numberOfPassengers) ||
                other.numberOfPassengers == numberOfPassengers) &&
            (identical(other.publicTransportType, publicTransportType) ||
                other.publicTransportType == publicTransportType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      option,
      vehicle,
      const DeepCollectionEquality().hash(_location),
      distance,
      duration,
      distanceUnit,
      durationUnit,
      fuelType,
      fuelConsumption,
      fuelConsumptionUnit,
      numberOfPassengers,
      publicTransportType);

  @override
  String toString() {
    return 'TransportationModel(option: $option, vehicle: $vehicle, location: $location, distance: $distance, duration: $duration, distanceUnit: $distanceUnit, durationUnit: $durationUnit, fuelType: $fuelType, fuelConsumption: $fuelConsumption, fuelConsumptionUnit: $fuelConsumptionUnit, numberOfPassengers: $numberOfPassengers, publicTransportType: $publicTransportType)';
  }
}

/// @nodoc
abstract mixin class _$TransportationModelCopyWith<$Res>
    implements $TransportationModelCopyWith<$Res> {
  factory _$TransportationModelCopyWith(_TransportationModel value,
          $Res Function(_TransportationModel) _then) =
      __$TransportationModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String option,
      String vehicle,
      List<double> location,
      double distance,
      double duration,
      String distanceUnit,
      String durationUnit,
      String? fuelType,
      double? fuelConsumption,
      String? fuelConsumptionUnit,
      int? numberOfPassengers,
      String? publicTransportType});
}

/// @nodoc
class __$TransportationModelCopyWithImpl<$Res>
    implements _$TransportationModelCopyWith<$Res> {
  __$TransportationModelCopyWithImpl(this._self, this._then);

  final _TransportationModel _self;
  final $Res Function(_TransportationModel) _then;

  /// Create a copy of TransportationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? option = null,
    Object? vehicle = null,
    Object? location = null,
    Object? distance = null,
    Object? duration = null,
    Object? distanceUnit = null,
    Object? durationUnit = null,
    Object? fuelType = freezed,
    Object? fuelConsumption = freezed,
    Object? fuelConsumptionUnit = freezed,
    Object? numberOfPassengers = freezed,
    Object? publicTransportType = freezed,
  }) {
    return _then(_TransportationModel(
      option: null == option
          ? _self.option
          : option // ignore: cast_nullable_to_non_nullable
              as String,
      vehicle: null == vehicle
          ? _self.vehicle
          : vehicle // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self._location
          : location // ignore: cast_nullable_to_non_nullable
              as List<double>,
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      distanceUnit: null == distanceUnit
          ? _self.distanceUnit
          : distanceUnit // ignore: cast_nullable_to_non_nullable
              as String,
      durationUnit: null == durationUnit
          ? _self.durationUnit
          : durationUnit // ignore: cast_nullable_to_non_nullable
              as String,
      fuelType: freezed == fuelType
          ? _self.fuelType
          : fuelType // ignore: cast_nullable_to_non_nullable
              as String?,
      fuelConsumption: freezed == fuelConsumption
          ? _self.fuelConsumption
          : fuelConsumption // ignore: cast_nullable_to_non_nullable
              as double?,
      fuelConsumptionUnit: freezed == fuelConsumptionUnit
          ? _self.fuelConsumptionUnit
          : fuelConsumptionUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfPassengers: freezed == numberOfPassengers
          ? _self.numberOfPassengers
          : numberOfPassengers // ignore: cast_nullable_to_non_nullable
              as int?,
      publicTransportType: freezed == publicTransportType
          ? _self.publicTransportType
          : publicTransportType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
