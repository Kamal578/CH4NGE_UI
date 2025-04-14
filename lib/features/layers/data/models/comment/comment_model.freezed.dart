// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentModel {
  String get commentId;
  String get userId;
  String get postId;
  String get content;
  int get likeNumber;
  int get sharesNumber;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommentModelCopyWith<CommentModel> get copyWith =>
      _$CommentModelCopyWithImpl<CommentModel>(
          this as CommentModel, _$identity);

  /// Serializes this CommentModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CommentModel &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.likeNumber, likeNumber) ||
                other.likeNumber == likeNumber) &&
            (identical(other.sharesNumber, sharesNumber) ||
                other.sharesNumber == sharesNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, commentId, userId, postId,
      content, likeNumber, sharesNumber);

  @override
  String toString() {
    return 'CommentModel(commentId: $commentId, userId: $userId, postId: $postId, content: $content, likeNumber: $likeNumber, sharesNumber: $sharesNumber)';
  }
}

/// @nodoc
abstract mixin class $CommentModelCopyWith<$Res> {
  factory $CommentModelCopyWith(
          CommentModel value, $Res Function(CommentModel) _then) =
      _$CommentModelCopyWithImpl;
  @useResult
  $Res call(
      {String commentId,
      String userId,
      String postId,
      String content,
      int likeNumber,
      int sharesNumber});
}

/// @nodoc
class _$CommentModelCopyWithImpl<$Res> implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._self, this._then);

  final CommentModel _self;
  final $Res Function(CommentModel) _then;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = null,
    Object? userId = null,
    Object? postId = null,
    Object? content = null,
    Object? likeNumber = null,
    Object? sharesNumber = null,
  }) {
    return _then(_self.copyWith(
      commentId: null == commentId
          ? _self.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
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
class _CommentModel implements CommentModel {
  const _CommentModel(
      {required this.commentId,
      required this.userId,
      required this.postId,
      required this.content,
      required this.likeNumber,
      required this.sharesNumber});
  factory _CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  @override
  final String commentId;
  @override
  final String userId;
  @override
  final String postId;
  @override
  final String content;
  @override
  final int likeNumber;
  @override
  final int sharesNumber;

  CommentModel toEntity() {
    return CommentModel(
      commentId: commentId,
      userId: userId,
      postId: postId,
      content: content,
      likeNumber: likeNumber,
      sharesNumber: sharesNumber,
    );
  }

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CommentModelCopyWith<_CommentModel> get copyWith =>
      __$CommentModelCopyWithImpl<_CommentModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CommentModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommentModel &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.likeNumber, likeNumber) ||
                other.likeNumber == likeNumber) &&
            (identical(other.sharesNumber, sharesNumber) ||
                other.sharesNumber == sharesNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, commentId, userId, postId,
      content, likeNumber, sharesNumber);

  @override
  String toString() {
    return 'CommentModel(commentId: $commentId, userId: $userId, postId: $postId, content: $content, likeNumber: $likeNumber, sharesNumber: $sharesNumber)';
  }
}

/// @nodoc
abstract mixin class _$CommentModelCopyWith<$Res>
    implements $CommentModelCopyWith<$Res> {
  factory _$CommentModelCopyWith(
          _CommentModel value, $Res Function(_CommentModel) _then) =
      __$CommentModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String commentId,
      String userId,
      String postId,
      String content,
      int likeNumber,
      int sharesNumber});
}

/// @nodoc
class __$CommentModelCopyWithImpl<$Res>
    implements _$CommentModelCopyWith<$Res> {
  __$CommentModelCopyWithImpl(this._self, this._then);

  final _CommentModel _self;
  final $Res Function(_CommentModel) _then;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? commentId = null,
    Object? userId = null,
    Object? postId = null,
    Object? content = null,
    Object? likeNumber = null,
    Object? sharesNumber = null,
  }) {
    return _then(_CommentModel(
      commentId: null == commentId
          ? _self.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
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
