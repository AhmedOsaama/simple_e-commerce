import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ecommerce/core/widgets/loading_indicator.dart';
import 'package:simple_ecommerce/features/home/data/models/Product.dart';
import 'package:simple_ecommerce/features/home/presentation/manager/product_cubit.dart';
import 'package:simple_ecommerce/features/home/presentation/manager/product_state.dart';

import 'product_item_widget.dart';

class ProductsGridView extends StatefulWidget {
  const ProductsGridView({
    super.key,
  });

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  // final ScrollController _scrollController = ScrollController();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   final cubit = context.read<ProductCubit>();
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !cubit.isLastPage) {
  //       log("Fetching more data.....");
  //       cubit.getProducts();           // Fetch more data when scrolling to the bottom
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductCubit>();
    return BlocBuilder<ProductCubit, ProductsState>(
      builder: (ctx, state) {
        if(state is ProductsLoading){
          if(cubit.products.isEmpty) {
            return SliverToBoxAdapter(child: const LoadingIndicator());
          }
          return buildProductsList(cubit.products, false);
        }
        if(state is ProductsFailure){
          return SliverToBoxAdapter(child: Center(child: Text(state.message),));
        }
        if(state is ProductsSuccess) {
          var products = state.productsList;
          var isLastPage = state.isLastPage;
          return buildProductsList(products, isLastPage);
        }
        return SliverToBoxAdapter(child: const SizedBox());
      },
    );
  }

  SliverGrid buildProductsList(List<Product> products, bool isLastPage) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
              (context, i) {
                  if (i == products.length) {
                  return const LoadingIndicator();
                }
                return ProductItemWidget(product: products[i],);
              },
          childCount: products.length + (isLastPage ? 0 : 1), // or however many items you have
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 160/257
          ));
    // return GridView.builder(
    //         controller: _scrollController,
    //           itemCount: products.length + (isLastPage ? 0 : 1),
    //       padding: const EdgeInsets.symmetric(horizontal: 20),
    //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 2,
    //           crossAxisSpacing: 15,
    //           mainAxisSpacing: 15,
    //           childAspectRatio: 160/257
    //       ),
    //       itemBuilder: (ctx, i) {
    //         if (i == products.length) {
    //           return const LoadingIndicator();
    //         }
    //         return ProductItemWidget(product: products[i],);
    //       });
  }
}