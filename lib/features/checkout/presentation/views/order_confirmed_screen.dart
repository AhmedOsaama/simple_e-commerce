import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_ecommerce/core/empty_padding.dart';
import 'package:simple_ecommerce/core/style_utils.dart';
import 'package:simple_ecommerce/generated/assets.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/widgets/generic_text_button.dart';

class OrderConfirmedScreen extends StatelessWidget {
  const OrderConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.imagesOrderConfirmed),
                40.ph,
                Text("Order Confirmed", style: TextStylesInter.textViewSemiBold22.copyWith(fontSize: 28, color: Color(0xff1D1E20)),),
                Text("Your order has been confirmed, we will send you confirmation email shortly.", textAlign: TextAlign.center, style: TextStylesInter.textViewRegular15.copyWith(color: Color(0xff8F959E)),),
              ],
            ),
          ),
          Spacer(),
          GenericTextButton(text: "Continue Shopping", onPressed: (){
            AppNavigator.popUntil(context: context,);
          })
        ],
      ),
    );
  }
}
