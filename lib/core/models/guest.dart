import 'package:customer_pesenin/core/models/table.dart';
import 'package:json_annotation/json_annotation.dart';

part 'guest.g.dart';

@JsonSerializable()
class GuestModel {
  
  @JsonKey(name: '_id')
  String? id;
  String? name;
  @JsonKey(name: 'device_detection')
  String? deviceDetection;
  @JsonKey(name: 'checkin_number')
  String? checkInNumber;
  @JsonKey(name: 'checkin_token')
  String? checkInToken;
  int? status;
  TableModel? table;

  GuestModel({
    required this.id,
    required this.name,
    required this.deviceDetection,
    required this.checkInNumber,
    required this.checkInToken,
    required this.status,
    required this.table,
  });

  factory GuestModel.fromJson(Map<String, dynamic> json) => _$GuestModelFromJson(json);

  Map<String, dynamic> toJson() => _$GuestModelToJson(this);

}