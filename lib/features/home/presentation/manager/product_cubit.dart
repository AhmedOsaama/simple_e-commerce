import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ecommerce/features/home/data/repos/product_repo.dart';
import 'package:simple_ecommerce/features/home/presentation/manager/category_state.dart';
import 'package:simple_ecommerce/features/home/presentation/manager/product_state.dart';

import '../../data/models/Product.dart';

class ProductCubit extends Cubit<ProductsState>{
  final ProductRepo productRepo;
  ProductCubit(this.productRepo) : super(ProductsInitial());

  List<Product> products = [];
  var isLastPage = false;
  var currentPage = 1;

  Future<void> getProducts() async {
    emit(ProductsLoading());
    var result = await productRepo.getProducts(currentPage);
    result.fold((failure) => emit(ProductsFailure(message: failure.message)), (productList) {
      log("Current page: $currentPage");
      if (productList.length < 10) {
        isLastPage = true;
      }
      currentPage++;
      products.addAll(productList);

        emit(ProductsSuccess(productsList: products, isLastPage: isLastPage));
    });
  }

  Future<void> editProduct({required int id, required String name, required double price}) async {
    // emit(ProductsLoading());
    var result = await productRepo.editProduct(id: id, name: name, price: price);
    result.fold((failure) => {}, (response) {
      var product = products.firstWhere((element) => element.id == id);
      product.title = name;
      product.price = price;
      emit(ProductsSuccess(productsList: products, isLastPage: isLastPage));
    });
  }


}