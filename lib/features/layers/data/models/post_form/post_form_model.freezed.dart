// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_form_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostFormModel {
  String get userId;
  String get title;
  @Uint8ListConverter()
  Uint8List get imageBytes;
  String get imageName;

  /// Create a copy of PostFormModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostFormModelCopyWith<PostFormModel> get copyWith =>
      _$PostFormModelCopyWithImpl<PostFormModel>(
          this as PostFormModel, _$identity);

  /// Serializes this PostFormModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostFormModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other.imageBytes, imageBytes) &&
            (identical(other.imageName, imageName) ||
                other.imageName == imageName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, title,
      const DeepCollectionEquality().hash(imageBytes), imageName);

  @override
  String toString() {
    return 'PostFormModel(userId: $userId, title: $title, imageBytes: $imageBytes, imageName: $imageName)';
  }
}

/// @nodoc
abstract mixin class $PostFormModelCopyWith<$Res> {
  factory $PostFormModelCopyWith(
          PostFormModel value, $Res Function(PostFormModel) _then) =
      _$PostFormModelCopyWithImpl;
  @useResult
  $Res call(
      {String userId,
      String title,
      @Uint8ListConverter() Uint8List imageBytes,
      String imageName});
}

/// @nodoc
class _$PostFormModelCopyWithImpl<$Res>
    implements $PostFormModelCopyWith<$Res> {
  _$PostFormModelCopyWithImpl(this._self, this._then);

  final PostFormModel _self;
  final $Res Function(PostFormModel) _then;

  /// Create a copy of PostFormModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? title = null,
    Object? imageBytes = null,
    Object? imageName = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageBytes: null == imageBytes
          ? _self.imageBytes
          : imageBytes // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      imageName: null == imageName
          ? _self.imageName
          : imageName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PostFormModel implements PostFormModel {
  const _PostFormModel(
      {required this.userId,
      required this.title,
      @Uint8ListConverter() required this.imageBytes,
      required this.imageName});
  factory _PostFormModel.fromJson(Map<String, dynamic> json) =>
      _$PostFormModelFromJson(json);

  @override
  final String userId;
  @override
  final String title;
  @override
  @Uint8ListConverter()
  final Uint8List imageBytes;
  @override
  final String imageName;

  /// Create a copy of PostFormModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostFormModelCopyWith<_PostFormModel> get copyWith =>
      __$PostFormModelCopyWithImpl<_PostFormModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PostFormModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostFormModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other.imageBytes, imageBytes) &&
            (identical(other.imageName, imageName) ||
                other.imageName == imageName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, title,
      const DeepCollectionEquality().hash(imageBytes), imageName);

  @override
  String toString() {
    return 'PostFormModel(userId: $userId, title: $title, imageBytes: $imageBytes, imageName: $imageName)';
  }
}

/// @nodoc
abstract mixin class _$PostFormModelCopyWith<$Res>
    implements $PostFormModelCopyWith<$Res> {
  factory _$PostFormModelCopyWith(
          _PostFormModel value, $Res Function(_PostFormModel) _then) =
      __$PostFormModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String userId,
      String title,
      @Uint8ListConverter() Uint8List imageBytes,
      String imageName});
}

/// @nodoc
class __$PostFormModelCopyWithImpl<$Res>
    implements _$PostFormModelCopyWith<$Res> {
  __$PostFormModelCopyWithImpl(this._self, this._then);

  final _PostFormModel _self;
  final $Res Function(_PostFormModel) _then;

  /// Create a copy of PostFormModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? title = null,
    Object? imageBytes = null,
    Object? imageName = null,
  }) {
    return _then(_PostFormModel(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageBytes: null == imageBytes
          ? _self.imageBytes
          : imageBytes // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      imageName: null == imageName
          ? _self.imageName
          : imageName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
