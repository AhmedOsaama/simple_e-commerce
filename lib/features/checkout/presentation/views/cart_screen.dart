import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ecommerce/core/style_utils.dart';
import 'package:simple_ecommerce/core/widgets/my_app_bar.dart';

import 'widgets/cart_screen_body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: Text("Cart", style: TextStylesInter.textViewSemiBold17,),),
      body: CartScreenBody(),
    );
  }
}
