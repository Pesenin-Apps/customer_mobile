// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableModel _$TableModelFromJson(Map<String, dynamic> json) {
  return TableModel(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    number: json['number'] as int?,
    status: json['status'] as int?,
    section: json['section'] == null
        ? null
        : TableSection.fromJson(json['section'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TableModelToJson(TableModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'number': instance.number,
      'status': instance.status,
      'section': instance.section,
    };

TableSection _$TableSectionFromJson(Map<String, dynamic> json) {
  return TableSection(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    code: json['code'] as String?,
  );
}

Map<String, dynamic> _$TableSectionToJson(TableSection instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
