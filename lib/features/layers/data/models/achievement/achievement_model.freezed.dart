// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AchievementModel {
  int get achievementId;
  int get userId;
  String get title;
  String get subtitle;
  bool get isAchieved;

  /// Create a copy of AchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AchievementModelCopyWith<AchievementModel> get copyWith =>
      _$AchievementModelCopyWithImpl<AchievementModel>(
          this as AchievementModel, _$identity);

  /// Serializes this AchievementModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AchievementModel &&
            (identical(other.achievementId, achievementId) ||
                other.achievementId == achievementId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.isAchieved, isAchieved) ||
                other.isAchieved == isAchieved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, achievementId, userId, title, subtitle, isAchieved);

  @override
  String toString() {
    return 'AchievementModel(achievementId: $achievementId, userId: $userId, title: $title, subtitle: $subtitle, isAchieved: $isAchieved)';
  }
}

/// @nodoc
abstract mixin class $AchievementModelCopyWith<$Res> {
  factory $AchievementModelCopyWith(
          AchievementModel value, $Res Function(AchievementModel) _then) =
      _$AchievementModelCopyWithImpl;
  @useResult
  $Res call(
      {int achievementId,
      int userId,
      String title,
      String subtitle,
      bool isAchieved});
}

/// @nodoc
class _$AchievementModelCopyWithImpl<$Res>
    implements $AchievementModelCopyWith<$Res> {
  _$AchievementModelCopyWithImpl(this._self, this._then);

  final AchievementModel _self;
  final $Res Function(AchievementModel) _then;

  /// Create a copy of AchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? achievementId = null,
    Object? userId = null,
    Object? title = null,
    Object? subtitle = null,
    Object? isAchieved = null,
  }) {
    return _then(_self.copyWith(
      achievementId: null == achievementId
          ? _self.achievementId
          : achievementId // ignore: cast_nullable_to_non_nullable
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
      isAchieved: null == isAchieved
          ? _self.isAchieved
          : isAchieved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AchievementModel implements AchievementModel {
  const _AchievementModel(
      {required this.achievementId,
      required this.userId,
      required this.title,
      required this.subtitle,
      required this.isAchieved});
  factory _AchievementModel.fromJson(Map<String, dynamic> json) =>
      _$AchievementModelFromJson(json);

  @override
  final int achievementId;
  @override
  final int userId;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final bool isAchieved;

  AchievementEntity toEntity() {
    return AchievementEntity(
      achievementId: achievementId,
      userId: userId,
      title: title,
      subtitle: subtitle,
      isAchieved: isAchieved,
    );
  }

  /// Create a copy of AchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AchievementModelCopyWith<_AchievementModel> get copyWith =>
      __$AchievementModelCopyWithImpl<_AchievementModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AchievementModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AchievementModel &&
            (identical(other.achievementId, achievementId) ||
                other.achievementId == achievementId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.isAchieved, isAchieved) ||
                other.isAchieved == isAchieved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, achievementId, userId, title, subtitle, isAchieved);

  @override
  String toString() {
    return 'AchievementModel(achievementId: $achievementId, userId: $userId, title: $title, subtitle: $subtitle, isAchieved: $isAchieved)';
  }
}

/// @nodoc
abstract mixin class _$AchievementModelCopyWith<$Res>
    implements $AchievementModelCopyWith<$Res> {
  factory _$AchievementModelCopyWith(
          _AchievementModel value, $Res Function(_AchievementModel) _then) =
      __$AchievementModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int achievementId,
      int userId,
      String title,
      String subtitle,
      bool isAchieved});
}

/// @nodoc
class __$AchievementModelCopyWithImpl<$Res>
    implements _$AchievementModelCopyWith<$Res> {
  __$AchievementModelCopyWithImpl(this._self, this._then);

  final _AchievementModel _self;
  final $Res Function(_AchievementModel) _then;

  /// Create a copy of AchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? achievementId = null,
    Object? userId = null,
    Object? title = null,
    Object? subtitle = null,
    Object? isAchieved = null,
  }) {
    return _then(_AchievementModel(
      achievementId: null == achievementId
          ? _self.achievementId
          : achievementId // ignore: cast_nullable_to_non_nullable
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
      isAchieved: null == isAchieved
          ? _self.isAchieved
          : isAchieved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
