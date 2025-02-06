import 'package:flutter/material.dart';

import '../../data/models/Product.dart';
import 'widgets/product_screen_body.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductScreenBody(product: product,),
    );
  }
}
