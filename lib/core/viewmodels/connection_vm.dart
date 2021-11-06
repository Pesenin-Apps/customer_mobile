import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class ConnectionVM extends ChangeNotifier {
  
  final Connectivity _connectivity = Connectivity();
  bool? _isOnline;

  bool? get isOnline => _isOnline;

  startMonitoring() async {
    await initConnection();
    _connectivity.onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        _updateConnectionStatus().then((bool isConnected) {
          _isOnline = isConnected;
          notifyListeners();
        });
      }
    });
  }

  Future<void> initConnection() async {
    try {
      var status = await _connectivity.checkConnectivity();
      if (status == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        _isOnline = true;
        notifyListeners();
      }
    } on PlatformException catch(e) {
      print('PlatformException : $e');
    }
  }

  Future<bool> _updateConnectionStatus() async {
    bool? isConnected;
    try {
      final List<InternetAddress> result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected!;
  }

}