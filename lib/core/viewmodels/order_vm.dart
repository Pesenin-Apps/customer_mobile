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
  Order? _guestOrder;

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

  Order get customerOrder {
    return _customerOrder!;
  }

  Order get guestOrder {
    return _guestOrder!;
  }

  bool get customerOrderIsPaid {
    return customerOrder.isPaid!;
  }

  bool get canChangedCustomerOrderExist {
    var orderItemsSelected = customerOrder.orderItem?.where((element) => element.status! <= orderItemStatusNew);
    return orderItemsSelected!.isNotEmpty;
  }

  bool get canNotChangedCustomerOrderExist {
    var orderItemsSelected = customerOrder.orderItem?.where((element) => element.status! > orderItemStatusNew);
    return orderItemsSelected!.isNotEmpty;
  }
  
  bool get canChangedGuestOrderExist {
    var orderItemsSelected = guestOrder.orderItem?.where((element) => element.status! <= orderItemStatusNew);
    return orderItemsSelected!.isNotEmpty;
  }

  bool get isExistGuestOrder {
    return _guestOrder != null;
  }

  Future fetchOnGoingCustomerOrders() async {
    final Map<String, dynamic> queryParams = {
      'filters': {
        'status' : [ 1, 2, 3 ],
        'is_paid' : false,
      }
    };
    _onGoingCustomerOrders = await api.getCustomerOrders(queryParams);
    notifyListeners();
  }

  Future fetchHistoryCustomerOrders() async {
    final Map<String, dynamic> queryParamsHistory = {
      'filters': {
        'status' : [ 1, 2, 3 ],
        'is_paid' : true, 
      }
    };
    _historyCustomerOrders = await api.getCustomerOrders(queryParamsHistory);
    notifyListeners();
    final Map<String, dynamic> queryParamsHistoryLimit = {
      'filters': {
        'status' : [ 1, 2, 3 ],
        'is_paid' : true, 
      },
      'limit': limitOrderHistory,
    };
    _historyCustomerOrderLimits = await api.getCustomerOrders(queryParamsHistoryLimit);
    notifyListeners();
  }

  Future fetchCustomerOrderDetail(String id) async {
    _customerOrder = await api.getOrder(id);
    notifyListeners();
  }

  Future<String> createCustomerOrder(String table, List<CartModel> carts) async {
    var response = await api.postCustomerOrder(table, carts);
    notifyListeners();
    if (response == 'null') {
      return 'null';
    } else {
      return response;
    }
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

  Future<bool> createCustomerReservation(Map<String, dynamic> createForm) async {
    final bool response = await api.postCustomerReservation(createForm);
    return response;
  }

  Future fetchGuestOrderDetail() async {
    _guestOrder = await api.getGuestOrders();
    notifyListeners();
  }

  Future<bool> createGuestOrder(List<CartModel> carts) async {
    final bool response = await api.postGuestOrder(carts);
    return response;
  }

  Future<bool> updateGuestOrderItem(String orderId, Map<String, dynamic> updateForm) async {
    final bool response = await api.patchGuestOrderItem(orderId, updateForm);
    return response;
  }

  Future<bool> removeGuestOrderItem(String orderId, Map<String, dynamic> deletedForm) async {
    final bool response = await api.deleteGuestOrderItem(orderId, deletedForm);
    return response;
  }

}