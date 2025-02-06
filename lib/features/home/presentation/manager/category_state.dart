
import '../../data/models/Product.dart';

sealed class CategoryState{}

class CategoriesInitial extends CategoryState{}

class CategoriesLoading extends CategoryState{}

class CategoriesSuccess extends CategoryState{
  final List<Category> categoriesList;
  CategoriesSuccess({required this.categoriesList});
}

class CategoriesFailure extends CategoryState{
  final String message;
  CategoriesFailure({required this.message});
}