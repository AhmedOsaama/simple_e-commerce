import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ecommerce/features/checkout/data/models/cart_item.dart';
import 'package:simple_ecommerce/features/checkout/data/repos/cart_repo.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState>{
  final CartRepo cartRepo;
  CartCubit(this.cartRepo) : super(CartInitial());

  List<CartItem> cartItems = [];

  void getStoredCartItems() async {
    emit(CartLoading());
    var result = cartRepo.getStoredCartItems();
    result.fold((failure) => emit(CartFailure(message: failure.message)), (cartList) {
      log("Cart list: $cartList");
      cartItems = cartList;
      emit(CartSuccess(cartItems: cartList));
    });
  }

  Future deleteStoredProductInCart(int id) async {
    emit(CartLoading());
    var result = await cartRepo.deleteStoredProductInCart(id);
    result.fold((failure) => emit(CartFailure(message: failure.message)), (_) {
      cartItems.removeWhere((element) => element.id == id);
      emit(CartSuccess(cartItems: cartItems));
    });
  }

  Future updateProductQuantity({required int newQty, required int id}) async {
    // emit(CartLoading());
    var result = await cartRepo.updateProductQuantity(newQty: newQty, id: id);
    result.fold((failure) => emit(CartFailure(message: failure.message)), (_) {
      cartItems.firstWhere((element) => element.id == id).qty = newQty;
      emit(CartSuccess(cartItems: cartItems));
    });
  }

  Future storeProductInCart(CartItem cartItem) async {
    // emit(CartLoading());
    var duplicateCardItemIndex = cartItems.indexWhere((element) => element.id == cartItem.id);
    if(duplicateCardItemIndex != -1){                         //adding duplicated cart item case
      log("Duplicated: ${cartItem.id}");
      updateProductQuantity(newQty: cartItems[duplicateCardItemIndex].qty! + 1, id: cartItem.id!);
      return;
    }
    var result = await cartRepo.storeProductInCart(cartItem);
    result.fold((failure) => emit(CartFailure(message: failure.message)), (_) {
      cartItems.add(cartItem);
      emit(CartSuccess(cartItems: cartItems));
    });
  }

}