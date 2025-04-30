import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_ecommerce/core/services/hive_helper.dart';
import 'package:simple_ecommerce/features/checkout/data/repos/cart_repo.dart';
import 'package:simple_ecommerce/features/checkout/presentation/manager/cart_cubit.dart';
import 'package:simple_ecommerce/features/home/data/repos/product_repo.dart';
import 'package:simple_ecommerce/features/home/presentation/manager/category_cubit.dart';
import 'package:simple_ecommerce/features/home/presentation/manager/product_cubit.dart';
import 'package:simple_ecommerce/features/registration/presentation/views/get_started_screen.dart';

import 'core/api_keys.dart';
import 'core/services/get_it_service.dart';
import 'features/home/presentation/views/home_screen.dart';

Future<void> main() async {
  Stripe.publishableKey = ApiKeys.stripePublishKey;
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Future.wait([
    HiveHelper.initHiveBox(),
    ScreenUtil.ensureScreenSize(),
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    ),
    // dotenv.load(),
  ]);
  // HiveHelper.cartBox.clear();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (ctx) => CartCubit(getIt<CartRepo>())..getStoredCartItems()
          ),
          BlocProvider(
              create: (ctx) => ProductCubit(getIt<ProductRepo>())..getProducts()
          ),
          BlocProvider(
              create: (ctx) => CategoryCubit(getIt<ProductRepo>())..getCategories()
          ),
        ],
        child: MaterialApp(
          title: 'Simple E-commerce',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: TextTheme(
              
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          // home: const HomeScreen(),
          home: const GetStartedScreen(),
        ),
      ),
    );
  }
}
