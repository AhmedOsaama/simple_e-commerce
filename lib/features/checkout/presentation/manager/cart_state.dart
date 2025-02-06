
import '../../data/models/cart_item.dart';

sealed class CartState{}

class CartInitial extends CartState{}

class CartLoading extends CartState{}

class CartSuccess extends CartState{
  final List<CartItem> cartItems;
  CartSuccess({required this.cartItems});
}

class CartFailure extends CartState{
  final String message;
  CartFailure({required this.message});
}