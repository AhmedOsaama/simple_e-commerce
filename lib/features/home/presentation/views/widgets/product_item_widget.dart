import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_ecommerce/core/app_navigator.dart';
import 'package:simple_ecommerce/core/empty_padding.dart';

import '../../../../../core/style_utils.dart';
import '../../../../../generated/assets.dart';
import '../../../data/models/Product.dart';
import '../product_screen.dart';
import 'edit_product_bottom_sheet.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;
  const ProductItemWidget({
    super.key, required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: (){
        AppNavigator.push(context: context, screen: ProductScreen(product: product,));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(product.images![0], )),
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(onPressed: (){
                    showModalBottomSheet(
                      isScrollControlled: true,
                        context: context, builder: (ctx) => EditProductBottomSheet(
                      product: product,
                    ));
                  }, icon: SvgPicture.asset(Assets.iconsEdit, color: Colors.white,)))
            ],
          ),
          10.ph,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.title!, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStylesInter.textViewMedium12,),
              5.ph,
              Text("\$${product.price!}", style: TextStylesInter.textViewSemiBold13,),
            ],
          ),
        ],
      ),
    );
  }
}
