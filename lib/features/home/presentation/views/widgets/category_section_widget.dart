import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ecommerce/core/widgets/loading_indicator.dart';
import 'package:simple_ecommerce/features/home/presentation/manager/category_cubit.dart';
import 'package:simple_ecommerce/features/home/presentation/manager/category_state.dart';

import '../../../../../core/style_utils.dart';

class CategorySectionWidget extends StatelessWidget {
  const CategorySectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (ctx, state) {
          if(state is CategoriesLoading){
            return LoadingIndicator();
          }
          if(state is CategoriesFailure){
            return Center(child: Text(state.message),);
          }
          if(state is CategoriesSuccess){
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: state.categoriesList.length,
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(state.categoriesList[i].image!),
                    ),
                    Text(state.categoriesList[i].name!, style: TextStylesInter.textViewMedium12,)
                  ],
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}