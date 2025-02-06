import 'package:flutter/material.dart';
import 'package:simple_ecommerce/core/empty_padding.dart';
import 'package:simple_ecommerce/core/style_utils.dart';

import 'category_section_widget.dart';
import 'products_gridview.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("Categories", style: TextStylesInter.textViewMedium13,),
        ),
        20.ph,
        const CategorySectionWidget(),
        35.ph,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("Products", style: TextStylesInter.textViewMedium16,),
        ),
        22.ph,
        const ProductsGridView(),
      ],
    );
  }
}



