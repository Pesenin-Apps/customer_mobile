// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaiterModel _$WaiterModelFromJson(Map<String, dynamic> json) {
  return WaiterModel(
    id: json['_id'] as String?,
    waiter: json['waiter'] as String?,
    users: json['users'] == null
        ? null
        : UserModel.fromJson(json['users'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WaiterModelToJson(WaiterModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'waiter': instance.waiter,
      'users': instance.users,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['_id'] as String?,
    fullname: json['fullname'] as String?,
    email: json['email'] as String?,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'fullname': instance.fullname,
      'email': instance.email,
    };
