// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
      userId: json['userId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      profilePicUrl: json['profilePicUrl'] as String,
      streak: (json['streak'] as num).toInt(),
      points: (json['points'] as num).toInt(),
      ghgIndex: (json['ghgIndex'] as num).toDouble(),
      location: (json['location'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      friendsIds: (json['friendsIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'profilePicUrl': instance.profilePicUrl,
      'streak': instance.streak,
      'points': instance.points,
      'ghgIndex': instance.ghgIndex,
      'location': instance.location,
      'friendsIds': instance.friendsIds,
    };
