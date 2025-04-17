import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String username,
    required String email,
    required String password,
    required String profilePicUrl,
    required int streak,
    required int points,
    required double ghgIndex,
    required List<double> location,
    required List<String> friendsIds,
  }) = _UserModel;

  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      username: username,
      email: email,
      password: password,
      profilePicUrl: profilePicUrl,
      streak: streak,
      points: points,
      ghgIndex: ghgIndex,
      location: LatLng(location[0], location[1]),
      friendsIds: friendsIds,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}