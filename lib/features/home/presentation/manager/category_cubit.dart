import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ecommerce/features/home/presentation/manager/category_state.dart';

import '../../data/repos/product_repo.dart';

class CategoryCubit extends Cubit<CategoryState>{
  final ProductRepo productRepo;
  CategoryCubit(this.productRepo) : super(CategoriesInitial());

  Future<void> getCategories() async {
    emit(CategoriesLoading());
    var result = await productRepo.getCategories();
    result.fold((failure) => emit(CategoriesFailure(message: failure.message)), (categoryList) {
      emit(CategoriesSuccess(categoriesList: categoryList));
    });
  }

}