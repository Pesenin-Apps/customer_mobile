import 'package:customer_pesenin/core/models/cart.dart';
import 'package:customer_pesenin/core/helpers/locator.dart';
import 'package:customer_pesenin/core/models/order.dart';
import 'package:customer_pesenin/core/services/api.dart';
import 'package:flutter/material.dart';

class OrderVM extends ChangeNotifier {

  Api api = locator<Api>();
  int limitOrderHistory = 1;
  List<Order> _onGoingCustomerOrders = [];
  List<Order> _historyCustomerOrders = [];
  List<Order> _historyCustomerOrderLimits = [];

  List<Order> get onGoingCustomerOrders {
    return [..._onGoingCustomerOrders];
  }

  List<Order> get historyCustomerOrders {
    return [..._historyCustomerOrders];
  }

  List<Order> get historyCustomerOrderLimits {
    return [..._historyCustomerOrderLimits];
  }

  bool get isLimited {
    return _historyCustomerOrders.length > limitOrderHistory;
  }

  Future fetchOnGoingCustomerOrders() async {
    final Map<String, dynamic> queryParams = {
      'filters': {
        'status' : [ 1, 2, 3 ],
        'is_paid' : false,
      }
    };
    _onGoingCustomerOrders = await api.getOrders(queryParams);
    notifyListeners();
  }

  Future fetchHistoryCustomerOrders() async {
    final Map<String, dynamic> queryParamsHistory = {
      'filters': {
        'status' : [ 1, 2, 3 ],
        'is_paid' : true, 
      }
    };
    _historyCustomerOrders = await api.getOrders(queryParamsHistory);
    notifyListeners();
    final Map<String, dynamic> queryParamsHistoryLimit = {
      'filters': {
        'status' : [ 1, 2, 3 ],
        'is_paid' : true, 
      },
      'limit': limitOrderHistory,
    };
    _historyCustomerOrderLimits = await api.getOrders(queryParamsHistoryLimit);
    notifyListeners();
  }

  // old

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