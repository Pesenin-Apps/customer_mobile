import 'package:get_it/get_it.dart';
import 'package:customer_pesenin/services/api.dart';
import 'package:customer_pesenin/services/navigation_custom.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<Api>(() => Api());
  locator.registerLazySingleton<NavigationCustom>(() => NavigationCustom());
}