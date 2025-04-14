// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mini_challenge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MiniChallengeModel {
  String get miniChallengeId;
  String get userId;
  String get title;
  String get subtitle;
  bool get isAchieved;
  int get points;

  /// Create a copy of MiniChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MiniChallengeModelCopyWith<MiniChallengeModel> get copyWith =>
      _$MiniChallengeModelCopyWithImpl<MiniChallengeModel>(
          this as MiniChallengeModel, _$identity);

  /// Serializes this MiniChallengeModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MiniChallengeModel &&
            (identical(other.miniChallengeId, miniChallengeId) ||
                other.miniChallengeId == miniChallengeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.isAchieved, isAchieved) ||
                other.isAchieved == isAchieved) &&
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, miniChallengeId, userId, title,
      subtitle, isAchieved, points);

  @override
  String toString() {
    return 'MiniChallengeModel(miniChallengeId: $miniChallengeId, userId: $userId, title: $title, subtitle: $subtitle, isAchieved: $isAchieved, points: $points)';
  }
}

/// @nodoc
abstract mixin class $MiniChallengeModelCopyWith<$Res> {
  factory $MiniChallengeModelCopyWith(
          MiniChallengeModel value, $Res Function(MiniChallengeModel) _then) =
      _$MiniChallengeModelCopyWithImpl;
  @useResult
  $Res call(
      {String miniChallengeId,
      String userId,
      String title,
      String subtitle,
      bool isAchieved,
      int points});
}

/// @nodoc
class _$MiniChallengeModelCopyWithImpl<$Res>
    implements $MiniChallengeModelCopyWith<$Res> {
  _$MiniChallengeModelCopyWithImpl(this._self, this._then);

  final MiniChallengeModel _self;
  final $Res Function(MiniChallengeModel) _then;

  /// Create a copy of MiniChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? miniChallengeId = null,
    Object? userId = null,
    Object? title = null,
    Object? subtitle = null,
    Object? isAchieved = null,
    Object? points = null,
  }) {
    return _then(_self.copyWith(
      miniChallengeId: null == miniChallengeId
          ? _self.miniChallengeId
          : miniChallengeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _self.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      isAchieved: null == isAchieved
          ? _self.isAchieved
          : isAchieved // ignore: cast_nullable_to_non_nullable
              as bool,
      points: null == points
          ? _self.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _MiniChallengeModel implements MiniChallengeModel {
  const _MiniChallengeModel(
      {required this.miniChallengeId,
      required this.userId,
      required this.title,
      required this.subtitle,
      required this.isAchieved,
      required this.points});
  factory _MiniChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$MiniChallengeModelFromJson(json);

  @override
  final String miniChallengeId;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final bool isAchieved;
  @override
  final int points;

  MiniChallengeEntity toEntity() {
    return MiniChallengeEntity(
      miniChallengeId: miniChallengeId,
      userId: userId,
      title: title,
      subtitle: subtitle,
      isAchieved: isAchieved,
      points: points,
    );
  }

  /// Create a copy of MiniChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MiniChallengeModelCopyWith<_MiniChallengeModel> get copyWith =>
      __$MiniChallengeModelCopyWithImpl<_MiniChallengeModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MiniChallengeModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MiniChallengeModel &&
            (identical(other.miniChallengeId, miniChallengeId) ||
                other.miniChallengeId == miniChallengeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.isAchieved, isAchieved) ||
                other.isAchieved == isAchieved) &&
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, miniChallengeId, userId, title,
      subtitle, isAchieved, points);

  @override
  String toString() {
    return 'MiniChallengeModel(miniChallengeId: $miniChallengeId, userId: $userId, title: $title, subtitle: $subtitle, isAchieved: $isAchieved, points: $points)';
  }
}

/// @nodoc
abstract mixin class _$MiniChallengeModelCopyWith<$Res>
    implements $MiniChallengeModelCopyWith<$Res> {
  factory _$MiniChallengeModelCopyWith(
          _MiniChallengeModel value, $Res Function(_MiniChallengeModel) _then) =
      __$MiniChallengeModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String miniChallengeId,
      String userId,
      String title,
      String subtitle,
      bool isAchieved,
      int points});
}

/// @nodoc
class __$MiniChallengeModelCopyWithImpl<$Res>
    implements _$MiniChallengeModelCopyWith<$Res> {
  __$MiniChallengeModelCopyWithImpl(this._self, this._then);

  final _MiniChallengeModel _self;
  final $Res Function(_MiniChallengeModel) _then;

  /// Create a copy of MiniChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? miniChallengeId = null,
    Object? userId = null,
    Object? title = null,
    Object? subtitle = null,
    Object? isAchieved = null,
    Object? points = null,
  }) {
    return _then(_MiniChallengeModel(
      miniChallengeId: null == miniChallengeId
          ? _self.miniChallengeId
          : miniChallengeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _self.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      isAchieved: null == isAchieved
          ? _self.isAchieved
          : isAchieved // ignore: cast_nullable_to_non_nullable
              as bool,
      points: null == points
          ? _self.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
