// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {
  String get userId;
  String get username;
  String get email;
  String get profilePicUrl;
  int get streak;
  int get points;
  double get ghgIndex;
  List<double> get location;
  List<String> get friendsIds;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<UserModel> get copyWith =>
      _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profilePicUrl, profilePicUrl) ||
                other.profilePicUrl == profilePicUrl) &&
            (identical(other.streak, streak) || other.streak == streak) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.ghgIndex, ghgIndex) ||
                other.ghgIndex == ghgIndex) &&
            const DeepCollectionEquality().equals(other.location, location) &&
            const DeepCollectionEquality()
                .equals(other.friendsIds, friendsIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      username,
      email,
      profilePicUrl,
      streak,
      points,
      ghgIndex,
      const DeepCollectionEquality().hash(location),
      const DeepCollectionEquality().hash(friendsIds));

  @override
  String toString() {
    return 'UserModel(userId: $userId, username: $username, email: $email, profilePicUrl: $profilePicUrl, streak: $streak, points: $points, ghgIndex: $ghgIndex, location: $location, friendsIds: $friendsIds)';
  }
}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) =
      _$UserModelCopyWithImpl;
  @useResult
  $Res call(
      {String userId,
      String username,
      String email,
      String profilePicUrl,
      int streak,
      int points,
      double ghgIndex,
      List<double> location,
      List<String> friendsIds});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? email = null,
    Object? profilePicUrl = null,
    Object? streak = null,
    Object? points = null,
    Object? ghgIndex = null,
    Object? location = null,
    Object? friendsIds = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicUrl: null == profilePicUrl
          ? _self.profilePicUrl
          : profilePicUrl // ignore: cast_nullable_to_non_nullable
              as String,
      streak: null == streak
          ? _self.streak
          : streak // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _self.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      ghgIndex: null == ghgIndex
          ? _self.ghgIndex
          : ghgIndex // ignore: cast_nullable_to_non_nullable
              as double,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as List<double>,
      friendsIds: null == friendsIds
          ? _self.friendsIds
          : friendsIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UserModel implements UserModel {
  const _UserModel(
      {required this.userId,
      required this.username,
      required this.email,
      required this.profilePicUrl,
      required this.streak,
      required this.points,
      required this.ghgIndex,
      required final List<double> location,
      required final List<String> friendsIds})
      : _location = location,
        _friendsIds = friendsIds;
  factory _UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  final String userId;
  @override
  final String username;
  @override
  final String email;
  @override
  final String profilePicUrl;
  @override
  final int streak;
  @override
  final int points;
  @override
  final double ghgIndex;
  final List<double> _location;
  @override
  List<double> get location {
    if (_location is EqualUnmodifiableListView) return _location;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_location);
  }

  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      username: username,
      email: email,
      profilePicUrl: profilePicUrl,
      streak: streak,
      points: points,
      ghgIndex: ghgIndex,
      location: LatLng(location[0], location[1]),
      friendsIds: friendsIds,
    );
  }

  final List<String> _friendsIds;
  @override
  List<String> get friendsIds {
    if (_friendsIds is EqualUnmodifiableListView) return _friendsIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_friendsIds);
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserModelCopyWith<_UserModel> get copyWith =>
      __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profilePicUrl, profilePicUrl) ||
                other.profilePicUrl == profilePicUrl) &&
            (identical(other.streak, streak) || other.streak == streak) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.ghgIndex, ghgIndex) ||
                other.ghgIndex == ghgIndex) &&
            const DeepCollectionEquality().equals(other._location, _location) &&
            const DeepCollectionEquality()
                .equals(other._friendsIds, _friendsIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      username,
      email,
      profilePicUrl,
      streak,
      points,
      ghgIndex,
      const DeepCollectionEquality().hash(_location),
      const DeepCollectionEquality().hash(_friendsIds));

  @override
  String toString() {
    return 'UserModel(userId: $userId, username: $username, email: $email, profilePicUrl: $profilePicUrl, streak: $streak, points: $points, ghgIndex: $ghgIndex, location: $location, friendsIds: $friendsIds)';
  }
}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(
          _UserModel value, $Res Function(_UserModel) _then) =
      __$UserModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String userId,
      String username,
      String email,
      String profilePicUrl,
      int streak,
      int points,
      double ghgIndex,
      List<double> location,
      List<String> friendsIds});
}

/// @nodoc
class __$UserModelCopyWithImpl<$Res> implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? email = null,
    Object? profilePicUrl = null,
    Object? streak = null,
    Object? points = null,
    Object? ghgIndex = null,
    Object? location = null,
    Object? friendsIds = null,
  }) {
    return _then(_UserModel(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicUrl: null == profilePicUrl
          ? _self.profilePicUrl
          : profilePicUrl // ignore: cast_nullable_to_non_nullable
              as String,
      streak: null == streak
          ? _self.streak
          : streak // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _self.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      ghgIndex: null == ghgIndex
          ? _self.ghgIndex
          : ghgIndex // ignore: cast_nullable_to_non_nullable
              as double,
      location: null == location
          ? _self._location
          : location // ignore: cast_nullable_to_non_nullable
              as List<double>,
      friendsIds: null == friendsIds
          ? _self._friendsIds
          : friendsIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
