import 'package:customer_pesenin/core/viewmodels/cart_vm.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/order_vm.dart';
import 'package:customer_pesenin/core/viewmodels/product_vm.dart';
import 'package:customer_pesenin/core/viewmodels/user_vm.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ProductVM>(create: (context) => ProductVM()),
  ChangeNotifierProvider<UserVM>(create: (context) => UserVM()),
  ChangeNotifierProvider<CartVM>(create: (context) => CartVM()),
  ChangeNotifierProvider<OrderVM>(create: (context) => OrderVM()),
  ChangeNotifierProvider<ConnectionVM>(create: (context) => ConnectionVM()),
];