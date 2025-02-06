import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_ecommerce/features/checkout/data/repos/cart_repo.dart';
import 'package:simple_ecommerce/features/checkout/data/repos/cart_repo_impl.dart';
import 'package:simple_ecommerce/features/home/data/repos/product_repo.dart';
import 'package:simple_ecommerce/features/home/data/repos/product_repo_impl.dart';

import 'network_services.dart';


var getIt = GetIt.instance;

void setupServiceLocator(){
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<NetworkServices>(NetworkServices(getIt<Dio>()));
  getIt.registerSingleton<CartRepo>(CartRepoImpl());
  getIt.registerSingleton<ProductRepo>(ProductRepoImpl(networkService: getIt<NetworkServices>()));
}