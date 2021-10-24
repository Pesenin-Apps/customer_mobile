import 'package:json_annotation/json_annotation.dart';

part 'table.g.dart';

@JsonSerializable()
class Table {
  
  @JsonKey(name: '_id')
  String? id;
  String? name;
  int? number;
  bool? used;
  TableSection? section;

  Table({
    required this.id,
    required this.name,
    required this.number,
    required this.used,
    required this.section,
  });

  factory Table.fromJson(Map<String, dynamic> json) => _$TableFromJson(json);

  Map<String, dynamic> toJson() => _$TableToJson(this);


}

@JsonSerializable()
class TableSection {

  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? code;

  TableSection({
    required this.id,
    required this.name,
    required this.code,
  });

  factory TableSection.fromJson(Map<String, dynamic> json) => _$TableSectionFromJson(json);

  Map<String, dynamic> toJson() => _$TableSectionToJson(this);

}