import 'package:customer_pesenin/core/models/table.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  
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

  Customer({
    required this.id,
    required this.name,
    required this.deviceDetection,
    required this.checkInNumber,
    required this.checkInToken,
    required this.status,
    required this.table,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

}