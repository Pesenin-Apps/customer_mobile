// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    id: json['_id'] as String?,
    orderNumber: json['order_number'] as String?,
    status: json['status'] as int?,
    orderItem: (json['order_items'] as List<dynamic>?)
        ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
        .toList(),
    tax: (json['tax'] as num?)?.toDouble(),
    totalPrice: (json['total_price'] as num?)?.toDouble(),
    totalOverall: (json['total_overall'] as num?)?.toDouble(),
    isPaid: json['is_paid'] as bool?,
    type: json['type'] as int?,
    via: json['via'] as int?,
    guest: json['guest'] == null
        ? null
        : GuestModel.fromJson(json['guest'] as Map<String, dynamic>),
    customer: json['customer'] == null
        ? null
        : UserModel.fromJson(json['customer'] as Map<String, dynamic>),
    table: json['table'] == null
        ? null
        : TableModel.fromJson(json['table'] as Map<String, dynamic>),
    createdAt: json['createdAt'] as String?,
    updatedAt: json['updatedAt'] as String?,
    waiter: json['waiter'] == null
        ? null
        : WaiterModel.fromJson(json['waiter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'order_number': instance.orderNumber,
      'status': instance.status,
      'order_items': instance.orderItem,
      'tax': instance.tax,
      'total_price': instance.totalPrice,
      'total_overall': instance.totalOverall,
      'is_paid': instance.isPaid,
      'type': instance.type,
      'via': instance.via,
      'guest': instance.guest,
      'customer': instance.customer,
      'table': instance.table,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'waiter': instance.waiter,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return OrderItem(
    id: json['_id'] as String?,
    order: json['order'] as String?,
    status: json['status'] as int?,
    product: json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    price: json['price'] as int?,
    total: json['total'] as int?,
    qty: json['qty'] as int?,
  );
}

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      '_id': instance.id,
      'order': instance.order,
      'status': instance.status,
      'product': instance.product,
      'price': instance.price,
      'total': instance.total,
      'qty': instance.qty,
    };
