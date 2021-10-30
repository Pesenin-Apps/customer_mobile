import 'package:customer_pesenin/core/models/customer.dart';
import 'package:customer_pesenin/core/models/product.dart';
import 'package:customer_pesenin/core/models/table.dart';
import 'package:customer_pesenin/core/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'order_number')
  String? orderNumber;
  int? status;
  @JsonKey(name: 'order_items')
  List<OrderItem>? orderItem;
  int? tax;
  @JsonKey(name: 'total_price')
  int? totalPrice;
  @JsonKey(name: 'total_overall')
  int? totalOverall;
  Customer? customer;
  TableModel? table;
  String? createdAt;
  String? updatedAt;
  WaiterModel? waiter;

  Order({
    required this.id,
    required this.orderNumber,
    required this.status,
    this.orderItem,
    required this.tax,
    required this.totalPrice,
    required this.totalOverall,
    required this.customer,
    required this.table,
    required this.waiter,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

}

@JsonSerializable()
class OrderItem {

  @JsonKey(name: '_id')
  String? id;
  String? order;
  int? status;
  Product? product;
  int? price;
  int? total;
  int? qty;

  OrderItem({
    required this.id,
    this.order,
    required this.status,
    required this.product,
    required this.price,
    required this.total,
    required this.qty,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
  
}