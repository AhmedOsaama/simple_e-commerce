import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:simple_ecommerce/core/errors/failure.dart';
import 'package:simple_ecommerce/features/home/data/models/Product.dart';
import 'package:simple_ecommerce/features/home/data/repos/product_repo.dart';

import '../../../../core/services/network_services.dart';

class ProductRepoImpl implements ProductRepo{
  final NetworkServices networkService;
  ProductRepoImpl({required this.networkService});

  @override
  Future<Either<ServerFailure, List<Product>>> getProducts(int pageNumber) async {
    try {
      var result = await networkService.getProducts(pageNumber);
      var productList = (result.data as List).map((e) => Product.fromJson(e)).toList();
      return Right(productList);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<ServerFailure, void>> editProduct({required int id, required String name, required double price}) async {
    try {
      await networkService.editProduct(id: id, name: name, price: price);
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<ServerFailure, List<Category>>> getCategories() async {
    try {
      var result = await networkService.getCategories();
      var categoryList = (result.data as List).map((e) => Category.fromJson(e)).toList();
      return Right(categoryList);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(
        message: e.toString(),
      ));
    }
  }


}