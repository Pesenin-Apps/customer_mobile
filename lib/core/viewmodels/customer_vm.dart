import 'package:customer_pesenin/core/helpers/locator.dart';
import 'package:customer_pesenin/core/services/api.dart';
import 'package:customer_pesenin/core/models/table.dart';
import 'package:flutter/material.dart';

class CustomerVM extends ChangeNotifier {
  
  Api api = locator<Api>();
  TableModel? _tableDetail;

  TableModel get tableDetail {
    return _tableDetail!;
  }

  Future fetchTableDetail(String id) async {
    _tableDetail = await api.getTable(id);
    notifyListeners();
  }
  
}