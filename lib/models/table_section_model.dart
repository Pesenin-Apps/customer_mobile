class TableSectionModel {

  String? id;
  String? name;
  String? code;
  String? createdAt;
  String? updatedAt;

  TableSectionModel({
    this.id,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  TableSectionModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    code = json['code'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

}