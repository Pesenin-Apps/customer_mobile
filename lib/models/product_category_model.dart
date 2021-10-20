class ProductCategoryModel {

  String? id;
  String? name;

  ProductCategoryModel({
    this.id,
    this.name,
  });

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
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


