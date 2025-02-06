import 'package:dartz/dartz.dart';
import 'package:simple_ecommerce/core/errors/failure.dart';
import 'package:simple_ecommerce/features/home/data/models/Product.dart';

abstract class ProductRepo{
  Future<Either<ServerFailure, List<Product>>> getProducts(int pageNumber);
  Future<Either<ServerFailure, void>> editProduct({required int id, required String name, required double price});
  Future<Either<ServerFailure, List<Category>>> getCategories();

}