import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:simple_ecommerce/core/app_navigator.dart';
import 'package:simple_ecommerce/core/empty_padding.dart';
import 'package:simple_ecommerce/core/services/hive_helper.dart';
import 'package:simple_ecommerce/core/services/stripe_service.dart';
import 'package:simple_ecommerce/core/style_utils.dart';
import 'package:simple_ecommerce/core/widgets/generic_text_button.dart';
import 'package:simple_ecommerce/core/widgets/loading_indicator.dart';
import 'package:simple_ecommerce/features/checkout/presentation/manager/cart_cubit.dart';
import 'package:simple_ecommerce/features/checkout/presentation/manager/cart_state.dart';

import '../../../data/models/payment_models/PaymentIntentInput.dart';
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
        if (state is CartLoading) {
          return const LoadingIndicator();
        }
        if (state is CartFailure) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is CartSuccess) {
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
                  )),
              15.ph,
              CheckoutSummaryWidget(cartSubtotal: cartSubtotal),
              const Spacer(),
              if (state.cartItems.isNotEmpty)
                GenericTextButton(
                    text: "Checkout",
                    onPressed: () async {
                      try {
                        var paymentAmount = (cartSubtotal + 10) * 100;
                        await executeStripePayment(context, paymentAmount);
                        AppNavigator.push(context: context, screen: const OrderConfirmedScreen());
                      } on StripeException catch (error) {
                        log("Checkout Error: $error");
                        if (error.error.code == FailureCode.Canceled) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${error.error.message}")));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Couldn't complete payment. Please try again!")));
                        }
                      }
                    })
            ],
          );
        }
        return SizedBox();
      },
    );
  }

  Future<void> executeStripePayment(BuildContext context, double amount) async {
    PaymentIntentInput paymentIntentInput = PaymentIntentInput(
      amount: amount.toInt().toString(),
      currency: 'USD',
      customerId: 'cus_Pt8oZDyGcyDHJB',
    );
    await StripeService().makePayment(paymentIntentInput);
  }

  void calcSubtotal(CartSuccess state) {
    state.cartItems.forEach((item) {
      log(item.price!.toString());
      cartSubtotal += item.price! * item.qty!;
      log(cartSubtotal.toString());
    });
  }
}
