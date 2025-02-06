import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_ecommerce/core/app_navigator.dart';
import 'package:simple_ecommerce/core/empty_padding.dart';
import 'package:simple_ecommerce/core/style_utils.dart';
import 'package:simple_ecommerce/core/widgets/generic_text_button.dart';
import 'package:simple_ecommerce/features/checkout/data/models/cart_item.dart';
import 'package:simple_ecommerce/features/checkout/presentation/manager/cart_cubit.dart';
import 'package:simple_ecommerce/features/home/data/models/Product.dart';

import '../../../../../generated/assets.dart';
import '../../../../checkout/presentation/views/cart_screen.dart';

class ProductScreenBody extends StatefulWidget {
  final Product product;
  const ProductScreenBody({super.key, required this.product});

  @override
  State<ProductScreenBody> createState() => _ProductScreenBodyState();
}

class _ProductScreenBodyState extends State<ProductScreenBody> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var product = widget.product;
    return Stack(
      children: [
        Image.network(product.images![0]),
        Column(
          children: [
            30.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        AppNavigator.pop(context: context);
                      },
                      style: IconButton.styleFrom(backgroundColor: Colors.white),
                      icon: Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios)),
                  IconButton(
                    onPressed: () {
                      AppNavigator.push(context: context, screen: const CartScreen());
                    },
                    icon: SvgPicture.asset(Assets.iconsBag),
                    style: IconButton.styleFrom(backgroundColor: Colors.white),
                  )
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.55,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.ph,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 250,
                              child: Text(
                                product.title!,
                                maxLines: 4,
                                style: TextStylesInter.textViewSemiBold22,
                              )),
                          Text(
                            "\$${product.price}",
                            style: TextStylesInter.textViewSemiBold22,
                          ),
                        ],
                      ),
                    ),
                    20.ph,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            product.images!.length,
                            (index) => ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    product.images![index],
                                    width: 77,
                                    height: 77,
                                  ),
                                )),
                      ),
                    ),
                    25.ph,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Description",
                        style: TextStylesInter.textViewSemiBold17,
                      ),
                    ),
                    10.ph,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.description!,
                            maxLines: isExpanded ? 100 : 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          // if (isOverflowing)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Text(
                              isExpanded ? "See less" : "See more",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const Spacer(),
                    130.ph,
                  ],
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GenericTextButton(
              text: "Add to Cart",
              onPressed: () async {
                await context.read<CartCubit>().storeProductInCart(CartItem(
                    id: product.id!.toInt(),
                    name: product.title,
                    price: product.price!.toDouble(),
                    imageURL: product.images![0]));
                Fluttertoast.showToast(msg: "Product Added to cart");
              }),
        ),
      ],
    );
  }
}
