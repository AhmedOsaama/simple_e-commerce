import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_ecommerce/core/empty_padding.dart';
import 'package:simple_ecommerce/core/services/hive_helper.dart';
import 'package:simple_ecommerce/core/style_utils.dart';
import 'package:simple_ecommerce/features/checkout/data/models/cart_item.dart';
import 'package:simple_ecommerce/features/checkout/presentation/manager/cart_cubit.dart';
import 'package:simple_ecommerce/generated/assets.dart';

class CartItemWidget extends StatefulWidget {
  final CartItem cartItem;
  const CartItemWidget({super.key, required this.cartItem});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late int quantity;

  @override
  void initState() {
    quantity = widget.cartItem.qty!;
    super.initState();
  }


  void _increaseQuantity() {
    context.read<CartCubit>().updateProductQuantity(newQty: ++quantity, id: widget.cartItem.id!);
  }

  void _decreaseQuantity() {
    if (quantity > 1) {
      context.read<CartCubit>().updateProductQuantity(newQty: --quantity, id: widget.cartItem.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(0xffFEFEFE),
          borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 24, color: Colors.black.withOpacity(0.09)
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.cartItem.imageURL!,
              width: 100,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          12.pw,

          // Product Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 170,
                child: Text(
                  widget.cartItem.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStylesInter.textViewMedium13.copyWith(color: const Color(0xff1D1E20)),
                ),
              ),
              10.ph,

              Text(
                "\$" + widget.cartItem.price!.toString(),
                style: TextStylesInter.textViewRegular11.copyWith(color: const Color(0xff8F959E)),
              ),
              10.ph,
              // Quantity Selector
              Row(
                children: [
                  IconButton(
                    style: IconButton.styleFrom(shape: const CircleBorder(
                      side: BorderSide(
                          color: Color(0xffDEDEDE)
                      ),)),
                    // iconSize: 10,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onPressed: _decreaseQuantity,
                  ),
                  15.pw,
                  Text(
                    "$quantity",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  15.pw,
                  IconButton(
                    style: IconButton.styleFrom(shape: const CircleBorder(
                      side: BorderSide(
                          color: Color(0xffDEDEDE)
                      ),)),
                    icon: const Icon(Icons.keyboard_arrow_up),
                    onPressed: _increaseQuantity,
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Delete Button
          IconButton(
            style: IconButton.styleFrom(shape: const CircleBorder(
              side: BorderSide(
              color: Color(0xffDEDEDE)
            ),)),
            icon: SvgPicture.asset(Assets.iconsDelete, width: 19,height: 19,),
            onPressed: () {
              context.read<CartCubit>().deleteStoredProductInCart(widget.cartItem.id!);
            },
          ),
        ],
      ),
    );
  }
}
