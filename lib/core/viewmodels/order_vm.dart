import 'package:customer_pesenin/core/models/cart.dart';
import 'package:customer_pesenin/core/helpers/locator.dart';
import 'package:customer_pesenin/core/models/order.dart';
import 'package:customer_pesenin/core/services/api.dart';
import 'package:flutter/material.dart';

class OrderVM extends ChangeNotifier {

  Api api = locator<Api>();
  Order? _orderDetail;

  Order get orderDetail {
    return _orderDetail!;
  }

  bool get isExist {
    return _orderDetail != null;
  }

  bool get isOrdering {
    var statusOrder = [ 2, 3, 4 ];
    return statusOrder.contains(_orderDetail!.status);
  }

  Future fetchOrderDetail() async {
    _orderDetail = await api.getOrder();
    notifyListeners();
  }

  Future<bool> createOrder(List<CartModel> carts) async {
    final bool response = await api.postOrder(carts);
    return response;
  }

}