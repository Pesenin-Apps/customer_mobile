class ProductTypeModel {

  String? id;
  String? name;

  ProductTypeModel({
    this.id,
    this.name,
  });

  ProductTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
  
}