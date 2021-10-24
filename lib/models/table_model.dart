import 'package:customer_pesenin/models/table_section_model.dart';

class TableModel {

  String? id;
  String? name;
  int? number;
  bool? used;
  TableSectionModel? section;
  String? createdAt;
  String? updatedAt;

  TableModel({
    this.id,
    this.name,
    this.number,
    this.used,
    this.section,
    this.createdAt,
    this.updatedAt,
  });

  TableModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    number = json['number'];
    used = json['used'];
    section = TableSectionModel.fromJson(json['section']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'used': used,
      'section': section?.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }


}