// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuestModel _$GuestModelFromJson(Map<String, dynamic> json) {
  return GuestModel(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    deviceDetection: json['device_detection'] as String?,
    checkInNumber: json['checkin_number'] as String?,
    checkInToken: json['checkin_token'] as String?,
    status: json['status'] as int?,
    table: json['table'] == null
        ? null
        : TableModel.fromJson(json['table'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GuestModelToJson(GuestModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'device_detection': instance.deviceDetection,
      'checkin_number': instance.checkInNumber,
      'checkin_token': instance.checkInToken,
      'status': instance.status,
      'table': instance.table,
    };
