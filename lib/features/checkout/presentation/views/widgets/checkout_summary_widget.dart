import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_ecommerce/core/empty_padding.dart';
import 'package:simple_ecommerce/generated/assets.dart';

import '../../../../../core/style_utils.dart';

class CheckoutSummaryWidget extends StatelessWidget {
  const CheckoutSummaryWidget({
    super.key,
    required this.cartSubtotal,
  });

  final double cartSubtotal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Payment Method", style: TextStylesInter.textViewMedium17,),
              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_outlined, size: 18,))
            ],
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F6FA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(Assets.imagesVisaCardLogo),
                ),
                15.pw,
                Column(
                  children: [
                    Text("Visa Classic", style: TextStylesInter.textViewRegular16.copyWith(color: const Color(0xff1D1E20)),),
                    Text("**** 7690", style: TextStylesInter.textViewRegular16.copyWith(color: const Color(0xff8F959E)),),
                  ],
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff4AC76D),
                  ),
                  child: const Icon(Icons.check, color: Colors.white,),
                )
              ],
            ),
          ),
          20.ph,
          Text("Order Info", style: TextStylesInter.textViewMedium17.copyWith(color: const Color(0xff1D1E20)),),
          10.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal", style: TextStylesInter.textViewRegular15.copyWith(color: const Color(0xff8F959E)),),
              Text("\$$cartSubtotal", style: TextStylesInter.textViewMedium16.copyWith(color: const Color(0xff1D1E20)),),
            ],
          ),Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Shipping cost", style: TextStylesInter.textViewRegular15.copyWith(color: const Color(0xff8F959E)),),
              Text("\$10", style: TextStylesInter.textViewMedium16.copyWith(color: const Color(0xff1D1E20)),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total", style: TextStylesInter.textViewRegular15.copyWith(color: const Color(0xff8F959E)),),
              Text("\$${cartSubtotal + 10}", style: TextStylesInter.textViewMedium16.copyWith(color: const Color(0xff1D1E20)),),
            ],
          ),
        ],
      ),
    );
  }
}
