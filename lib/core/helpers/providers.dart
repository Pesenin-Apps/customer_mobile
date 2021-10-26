import 'package:customer_pesenin/core/viewmodels/customer_vm.dart';
import 'package:customer_pesenin/core/viewmodels/product_vm.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ProductVM>(create: (context) => ProductVM()),
  ChangeNotifierProvider<CustomerVM>(create: (context) => CustomerVM()),
];