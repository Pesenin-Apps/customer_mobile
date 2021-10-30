import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class WaiterModel {

  @JsonKey(name: '_id')
  String? id;
  String? waiter;
  UserModel? users;

  WaiterModel({
    required this.id,
    required this.waiter,
    required this.users,
  });

  factory WaiterModel.fromJson(Map<String, dynamic> json) => _$WaiterModelFromJson(json);

  Map<String, dynamic> toJson() => _$WaiterModelToJson(this);

}

@JsonSerializable()
class UserModel {
  
  @JsonKey(name: '_id')
  String? id;
  String? fullname;
  String? email;

  UserModel({
    required this.id,
    required this.fullname,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}