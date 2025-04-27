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
  String get postId;
  String get userId;
  List<String> get commentIds;
  String get title;
  String get imageUrl;
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
            const DeepCollectionEquality()
                .equals(other.commentIds, commentIds) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
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
      const DeepCollectionEquality().hash(commentIds),
      title,
      imageUrl,
      likeNumber,
      sharesNumber);

  @override
  String toString() {
    return 'PostModel(postId: $postId, userId: $userId, commentIds: $commentIds, title: $title, imageUrl: $imageUrl, likeNumber: $likeNumber, sharesNumber: $sharesNumber)';
  }
}

/// @nodoc
abstract mixin class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) _then) =
      _$PostModelCopyWithImpl;
  @useResult
  $Res call(
      {String postId,
      String userId,
      List<String> commentIds,
      String title,
      String imageUrl,
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
    Object? commentIds = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? likeNumber = null,
    Object? sharesNumber = null,
  }) {
    return _then(_self.copyWith(
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      commentIds: null == commentIds
          ? _self.commentIds
          : commentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
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
      required final List<String> commentIds,
      required this.title,
      required this.imageUrl,
      required this.likeNumber,
      required this.sharesNumber})
      : _commentIds = commentIds;
  factory _PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  @override
  final String postId;
  @override
  final String userId;
  final List<String> _commentIds;
  @override
  List<String> get commentIds {
    if (_commentIds is EqualUnmodifiableListView) return _commentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commentIds);
  }

  @override
  final String title;
  @override
  final String imageUrl;
  @override
  final int likeNumber;
  @override
  final int sharesNumber;

  PostEntity toEntity() {
    return PostEntity(
      postId: postId,
      userId: userId,
      commentIds: commentIds,
      title: title,
      imageUrl: imageUrl,
      likeNumber: likeNumber,
      sharesNumber: sharesNumber,
    );
  }

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
            const DeepCollectionEquality()
                .equals(other._commentIds, _commentIds) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
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
      const DeepCollectionEquality().hash(_commentIds),
      title,
      imageUrl,
      likeNumber,
      sharesNumber);

  @override
  String toString() {
    return 'PostModel(postId: $postId, userId: $userId, commentIds: $commentIds, title: $title, imageUrl: $imageUrl, likeNumber: $likeNumber, sharesNumber: $sharesNumber)';
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
      {String postId,
      String userId,
      List<String> commentIds,
      String title,
      String imageUrl,
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
    Object? commentIds = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? likeNumber = null,
    Object? sharesNumber = null,
  }) {
    return _then(_PostModel(
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      commentIds: null == commentIds
          ? _self._commentIds
          : commentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
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
