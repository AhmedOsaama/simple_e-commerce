
import '../../data/models/Product.dart';

sealed class ProductsState{}

class ProductsInitial extends ProductsState{}

class ProductsLoading extends ProductsState{}

class ProductsSuccess extends ProductsState{
  final List<Product> productsList;
  final bool isLastPage;
  ProductsSuccess({required this.productsList, required this.isLastPage});
}

class ProductsFailure extends ProductsState{
  final String message;
  ProductsFailure({required this.message});
}