import 'package:dartz/dartz.dart';
import 'package:simple_ecommerce/core/errors/failure.dart';
import 'package:simple_ecommerce/core/services/hive_helper.dart';
import 'package:simple_ecommerce/features/checkout/data/models/cart_item.dart';
import 'package:simple_ecommerce/features/checkout/data/repos/cart_repo.dart';

class CartRepoImpl implements CartRepo{
  @override
  Either<Failure, List<CartItem>> getStoredCartItems() {
    try{
      List cartItemsDB = HiveHelper.getStoredCartItems();
      List<CartItem> cartItems = cartItemsDB.map((e) => CartItem.fromJson(e)).toList();
      return Right(cartItems);
    }catch(e){
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStoredProductInCart(int id) async {
    try{
      await HiveHelper.deleteStoredProductInCart(id);
      return const Right(null);
    }catch(e){
      return Left(ServerFailure(message: e.toString()));
    }
  }


  @override
  Future<Either<Failure, dynamic>> storeProductInCart(CartItem cartItem) async {
    try{
      var cartItemMap = cartItem.toJson();
      await HiveHelper.storeProductInCart(cartItemMap);
      return const Right(null);
    }catch(e){
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> updateProductQuantity({required int newQty, required int id}) async {
    try{
      await HiveHelper.updateProductQuantity(newQty: newQty, id: id);
      return const Right(null);
    }catch(e){
      return Left(ServerFailure(message: e.toString()));
    }
  }

}