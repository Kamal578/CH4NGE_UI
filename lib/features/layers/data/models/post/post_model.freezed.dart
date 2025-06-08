// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostModel {
  int get postId;
  int get userId;
  String get title;
  String get imageUrl;
  List<int> get likedBy;
  List<int> get sharedBy;
  int get likeNumber;
  int get sharesNumber;

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostModelCopyWith<PostModel> get copyWith =>
      _$PostModelCopyWithImpl<PostModel>(this as PostModel, _$identity);

  /// Serializes this PostModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostModel &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other.likedBy, likedBy) &&
            const DeepCollectionEquality().equals(other.sharedBy, sharedBy) &&
            (identical(other.likeNumber, likeNumber) ||
                other.likeNumber == likeNumber) &&
            (identical(other.sharesNumber, sharesNumber) ||
                other.sharesNumber == sharesNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      postId,
      userId,
      title,
      imageUrl,
      const DeepCollectionEquality().hash(likedBy),
      const DeepCollectionEquality().hash(sharedBy),
      likeNumber,
      sharesNumber);

  @override
  String toString() {
    return 'PostModel(postId: $postId, userId: $userId, title: $title, imageUrl: $imageUrl, likedBy: $likedBy, sharedBy: $sharedBy, likeNumber: $likeNumber, sharesNumber: $sharesNumber)';
  }
}

/// @nodoc
abstract mixin class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) _then) =
      _$PostModelCopyWithImpl;
  @useResult
  $Res call(
      {int postId,
      int userId,
      String title,
      String imageUrl,
      List<int> likedBy,
      List<int> sharedBy,
      int likeNumber,
      int sharesNumber});
}

/// @nodoc
class _$PostModelCopyWithImpl<$Res> implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._self, this._then);

  final PostModel _self;
  final $Res Function(PostModel) _then;

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? userId = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? likedBy = null,
    Object? sharedBy = null,
    Object? likeNumber = null,
    Object? sharesNumber = null,
  }) {
    return _then(_self.copyWith(
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      likedBy: null == likedBy
          ? _self.likedBy
          : likedBy // ignore: cast_nullable_to_non_nullable
              as List<int>,
      sharedBy: null == sharedBy
          ? _self.sharedBy
          : sharedBy // ignore: cast_nullable_to_non_nullable
              as List<int>,
      likeNumber: null == likeNumber
          ? _self.likeNumber
          : likeNumber // ignore: cast_nullable_to_non_nullable
              as int,
      sharesNumber: null == sharesNumber
          ? _self.sharesNumber
          : sharesNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PostModel implements PostModel {
  const _PostModel(
      {required this.postId,
      required this.userId,
      required this.title,
      required this.imageUrl,
      required final List<int> likedBy,
      required final List<int> sharedBy,
      required this.likeNumber,
      required this.sharesNumber})
      : _likedBy = likedBy,
        _sharedBy = sharedBy;
  factory _PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  @override
  final int postId;
  @override
  final int userId;
  @override
  final String title;
  @override
  final String imageUrl;
  final List<int> _likedBy;
  @override
  List<int> get likedBy {
    if (_likedBy is EqualUnmodifiableListView) return _likedBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likedBy);
  }

  PostEntity toEntity() {
    return PostEntity(
      postId: postId,
      userId: userId,
      title: title,
      imageUrl: imageUrl,
      likedBy: likedBy,
      sharedBy: sharedBy,
      likeNumber: likeNumber,
      sharesNumber: sharesNumber,
    );
  }

  final List<int> _sharedBy;
  @override
  List<int> get sharedBy {
    if (_sharedBy is EqualUnmodifiableListView) return _sharedBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sharedBy);
  }

  @override
  final int likeNumber;
  @override
  final int sharesNumber;

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostModelCopyWith<_PostModel> get copyWith =>
      __$PostModelCopyWithImpl<_PostModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PostModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostModel &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._likedBy, _likedBy) &&
            const DeepCollectionEquality().equals(other._sharedBy, _sharedBy) &&
            (identical(other.likeNumber, likeNumber) ||
                other.likeNumber == likeNumber) &&
            (identical(other.sharesNumber, sharesNumber) ||
                other.sharesNumber == sharesNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      postId,
      userId,
      title,
      imageUrl,
      const DeepCollectionEquality().hash(_likedBy),
      const DeepCollectionEquality().hash(_sharedBy),
      likeNumber,
      sharesNumber);

  @override
  String toString() {
    return 'PostModel(postId: $postId, userId: $userId, title: $title, imageUrl: $imageUrl, likedBy: $likedBy, sharedBy: $sharedBy, likeNumber: $likeNumber, sharesNumber: $sharesNumber)';
  }
}

/// @nodoc
abstract mixin class _$PostModelCopyWith<$Res>
    implements $PostModelCopyWith<$Res> {
  factory _$PostModelCopyWith(
          _PostModel value, $Res Function(_PostModel) _then) =
      __$PostModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int postId,
      int userId,
      String title,
      String imageUrl,
      List<int> likedBy,
      List<int> sharedBy,
      int likeNumber,
      int sharesNumber});
}

/// @nodoc
class __$PostModelCopyWithImpl<$Res> implements _$PostModelCopyWith<$Res> {
  __$PostModelCopyWithImpl(this._self, this._then);

  final _PostModel _self;
  final $Res Function(_PostModel) _then;

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? postId = null,
    Object? userId = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? likedBy = null,
    Object? sharedBy = null,
    Object? likeNumber = null,
    Object? sharesNumber = null,
  }) {
    return _then(_PostModel(
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      likedBy: null == likedBy
          ? _self._likedBy
          : likedBy // ignore: cast_nullable_to_non_nullable
              as List<int>,
      sharedBy: null == sharedBy
          ? _self._sharedBy
          : sharedBy // ignore: cast_nullable_to_non_nullable
              as List<int>,
      likeNumber: null == likeNumber
          ? _self.likeNumber
          : likeNumber // ignore: cast_nullable_to_non_nullable
              as int,
      sharesNumber: null == sharesNumber
          ? _self.sharesNumber
          : sharesNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
