import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ecommerce/core/app_navigator.dart';
import 'package:simple_ecommerce/core/empty_padding.dart';
import 'package:simple_ecommerce/core/services/hive_helper.dart';
import 'package:simple_ecommerce/core/style_utils.dart';
import 'package:simple_ecommerce/core/widgets/generic_text_button.dart';
import 'package:simple_ecommerce/core/widgets/loading_indicator.dart';
import 'package:simple_ecommerce/features/checkout/presentation/manager/cart_cubit.dart';
import 'package:simple_ecommerce/features/checkout/presentation/manager/cart_state.dart';

import '../order_confirmed_screen.dart';
import 'cart_item_widget.dart';
import 'checkout_summary_widget.dart';

class CartScreenBody extends StatelessWidget {
  CartScreenBody({super.key});

  double cartSubtotal = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
        builder: (ctx, state) {
          if(state is CartLoading){
            return const LoadingIndicator();
          }
          if(state is CartFailure){
            return Center(child: Text(state.message),);
          }
          if(state is CartSuccess) {
            cartSubtotal = 0;
            calcSubtotal(state);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.ph,
                SizedBox(
                    height: 300,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: state.cartItems.length,
                      separatorBuilder: (ctx, i) => 15.ph,
                      itemBuilder: (ctx, i) => CartItemWidget(
                        cartItem: state.cartItems[i],
                      ),
                    )
                ),
                15.ph,
                CheckoutSummaryWidget(cartSubtotal: cartSubtotal),
                const Spacer(),
                if(state.cartItems.isNotEmpty)
                GenericTextButton(text: "Checkout", onPressed: (){
                  AppNavigator.push(context: context, screen: const OrderConfirmedScreen());
                })
              ],
            );

          }
          return SizedBox();
        },
    );
  }

  void calcSubtotal(CartSuccess state) {
     state.cartItems.forEach((item) {
      log(item.price!.toString());
      cartSubtotal += item.price! * item.qty!;
      log(cartSubtotal.toString());
    });
  }
}

