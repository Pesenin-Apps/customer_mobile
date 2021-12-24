import 'package:customer_pesenin/core/models/cart.dart';
import 'package:customer_pesenin/core/helpers/locator.dart';
import 'package:customer_pesenin/core/models/order.dart';
import 'package:customer_pesenin/core/services/api.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:flutter/material.dart';

class OrderVM extends ChangeNotifier {

  Api api = locator<Api>();
  int limitOrderHistory = 1;
  List<Order> _onGoingCustomerOrders = [];
  List<Order> _historyCustomerOrders = [];
  List<Order> _historyCustomerOrderLimits = [];
  Order? _customerOrder;

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

  Order get order {
    return _customerOrder!;
  }

  bool get orderIsPaid {
    return order.isPaid!;
  }

  bool get canChangedOrderExist {
    var orderItemsSelected = order.orderItem?.where((element) => element.status! <= orderItemStatusNew);
    return orderItemsSelected!.isNotEmpty;
  }

  bool get canNotChangedOrderExist {
    var orderItemsSelected = order.orderItem?.where((element) => element.status! > orderItemStatusNew);
    return orderItemsSelected!.isNotEmpty;
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

  Future fetchCustomerOrderDetail(String id) async {
    _customerOrder = await api.getOrder(id);
    notifyListeners();
  }

  Future<bool> cancelCustomerOrder(String id) async {
    final bool response = await api.postCancelCustomerOrder(id);
    return response;
  }

  Future<bool> updateCustomerOrderItem(String orderId, Map<String, dynamic> updateForm) async {
    final bool response = await api.patchCustomerOrderItem(orderId, updateForm);
    return response;
  }

  Future<bool> removeCustomerOrderItem(String orderId, Map<String, dynamic> deletedForm) async {
    final bool response = await api.deleteCustomerOrderItem(orderId, deletedForm);
    return response;
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
    _orderDetail = await api.getOrderGuest();
    notifyListeners();
  }

  Future<bool> createOrder(List<CartModel> carts) async {
    final bool response = await api.postOrder(carts);
    return response;
  }

}