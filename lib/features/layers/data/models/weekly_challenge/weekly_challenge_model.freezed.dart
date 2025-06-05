// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_challenge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeeklyChallengeModel {
  int get weekklyChallengeId;
  int get userId;
  String get title;
  String get subtitle;
  double get currentValue;
  double get totalValue;
  int get points;

  /// Create a copy of WeeklyChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WeeklyChallengeModelCopyWith<WeeklyChallengeModel> get copyWith =>
      _$WeeklyChallengeModelCopyWithImpl<WeeklyChallengeModel>(
          this as WeeklyChallengeModel, _$identity);

  /// Serializes this WeeklyChallengeModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WeeklyChallengeModel &&
            (identical(other.weekklyChallengeId, weekklyChallengeId) ||
                other.weekklyChallengeId == weekklyChallengeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.totalValue, totalValue) ||
                other.totalValue == totalValue) &&
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, weekklyChallengeId, userId,
      title, subtitle, currentValue, totalValue, points);

  @override
  String toString() {
    return 'WeeklyChallengeModel(weekklyChallengeId: $weekklyChallengeId, userId: $userId, title: $title, subtitle: $subtitle, currentValue: $currentValue, totalValue: $totalValue, points: $points)';
  }
}

/// @nodoc
abstract mixin class $WeeklyChallengeModelCopyWith<$Res> {
  factory $WeeklyChallengeModelCopyWith(WeeklyChallengeModel value,
          $Res Function(WeeklyChallengeModel) _then) =
      _$WeeklyChallengeModelCopyWithImpl;
  @useResult
  $Res call(
      {int weekklyChallengeId,
      int userId,
      String title,
      String subtitle,
      double currentValue,
      double totalValue,
      int points});
}

/// @nodoc
class _$WeeklyChallengeModelCopyWithImpl<$Res>
    implements $WeeklyChallengeModelCopyWith<$Res> {
  _$WeeklyChallengeModelCopyWithImpl(this._self, this._then);

  final WeeklyChallengeModel _self;
  final $Res Function(WeeklyChallengeModel) _then;

  /// Create a copy of WeeklyChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekklyChallengeId = null,
    Object? userId = null,
    Object? title = null,
    Object? subtitle = null,
    Object? currentValue = null,
    Object? totalValue = null,
    Object? points = null,
  }) {
    return _then(_self.copyWith(
      weekklyChallengeId: null == weekklyChallengeId
          ? _self.weekklyChallengeId
          : weekklyChallengeId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _self.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      currentValue: null == currentValue
          ? _self.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double,
      totalValue: null == totalValue
          ? _self.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
      points: null == points
          ? _self.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WeeklyChallengeModel implements WeeklyChallengeModel {
  const _WeeklyChallengeModel(
      {required this.weekklyChallengeId,
      required this.userId,
      required this.title,
      required this.subtitle,
      required this.currentValue,
      required this.totalValue,
      required this.points});
  factory _WeeklyChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyChallengeModelFromJson(json);

  @override
  final int weekklyChallengeId;
  @override
  final int userId;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final double currentValue;
  @override
  final double totalValue;
  @override
  final int points;

  WeeklyChallengeEntity toEntity() {
    return WeeklyChallengeEntity(
      weeklyChallengeId: weekklyChallengeId,
      userId: userId,
      title: title,
      subtitle: subtitle,
      currentValue: currentValue,
      totalValue: totalValue,
      points: points,
    );
  }

  /// Create a copy of WeeklyChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WeeklyChallengeModelCopyWith<_WeeklyChallengeModel> get copyWith =>
      __$WeeklyChallengeModelCopyWithImpl<_WeeklyChallengeModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WeeklyChallengeModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WeeklyChallengeModel &&
            (identical(other.weekklyChallengeId, weekklyChallengeId) ||
                other.weekklyChallengeId == weekklyChallengeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.totalValue, totalValue) ||
                other.totalValue == totalValue) &&
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, weekklyChallengeId, userId,
      title, subtitle, currentValue, totalValue, points);

  @override
  String toString() {
    return 'WeeklyChallengeModel(weekklyChallengeId: $weekklyChallengeId, userId: $userId, title: $title, subtitle: $subtitle, currentValue: $currentValue, totalValue: $totalValue, points: $points)';
  }
}

/// @nodoc
abstract mixin class _$WeeklyChallengeModelCopyWith<$Res>
    implements $WeeklyChallengeModelCopyWith<$Res> {
  factory _$WeeklyChallengeModelCopyWith(_WeeklyChallengeModel value,
          $Res Function(_WeeklyChallengeModel) _then) =
      __$WeeklyChallengeModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int weekklyChallengeId,
      int userId,
      String title,
      String subtitle,
      double currentValue,
      double totalValue,
      int points});
}

/// @nodoc
class __$WeeklyChallengeModelCopyWithImpl<$Res>
    implements _$WeeklyChallengeModelCopyWith<$Res> {
  __$WeeklyChallengeModelCopyWithImpl(this._self, this._then);

  final _WeeklyChallengeModel _self;
  final $Res Function(_WeeklyChallengeModel) _then;

  /// Create a copy of WeeklyChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? weekklyChallengeId = null,
    Object? userId = null,
    Object? title = null,
    Object? subtitle = null,
    Object? currentValue = null,
    Object? totalValue = null,
    Object? points = null,
  }) {
    return _then(_WeeklyChallengeModel(
      weekklyChallengeId: null == weekklyChallengeId
          ? _self.weekklyChallengeId
          : weekklyChallengeId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _self.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      currentValue: null == currentValue
          ? _self.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double,
      totalValue: null == totalValue
          ? _self.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
      points: null == points
          ? _self.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
