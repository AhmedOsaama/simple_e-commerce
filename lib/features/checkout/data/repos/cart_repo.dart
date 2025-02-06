import 'package:dartz/dartz.dart';
import 'package:simple_ecommerce/features/checkout/data/models/cart_item.dart';

import '../../../../core/errors/failure.dart';

abstract class CartRepo{
  Either<Failure, List<CartItem>> getStoredCartItems();
  Future<Either<Failure, void>> deleteStoredProductInCart(int id);
  Future<Either<Failure, dynamic>> updateProductQuantity({required int newQty, required int id});
  Future<Either<Failure, dynamic>> storeProductInCart(CartItem cartItem);
}