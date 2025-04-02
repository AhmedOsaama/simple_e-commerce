import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ecommerce/core/app_colors.dart';
import 'package:simple_ecommerce/core/empty_padding.dart';
import 'package:simple_ecommerce/core/style_utils.dart';
import 'package:simple_ecommerce/core/widgets/generic_form_field.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../manager/product_cubit.dart';
import 'category_section_widget.dart';
import 'products_gridview.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final ScrollController _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProductCubit>();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !cubit.isLastPage) {
        log("Fetching more data.....");
        cubit.getProducts();           // Fetch more data when scrolling to the bottom
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            children: [
              10.pw,
            Expanded(
              // flex: 35,
              child: GenericFormField(filled: true,
                controller: _searchController, validator: (){}, borderColor: Colors.transparent, borderRadius: 10,
              ),
            ),
              10.pw,
              SizedBox(
                width: 70,
                  height: 50,
                  child: ElevatedButton(onPressed: () async {
                    SpeechToText speech = SpeechToText();
                    bool available = await speech.initialize( onStatus: (status){
                      log(status);
                    }, onError: (error) => log(error.errorMsg) );
                    if ( available ) {
                      speech.listen( onResult: (words) => _searchController.text = words.recognizedWords);
                    }
                    else {
                      print("The user has denied the use of speech recognition.");
                    }
                    // some time later...
                    // speech.stop();
                  }, child: Icon(Icons.mic_none_outlined, color: Colors.white,), style: ElevatedButton.styleFrom(backgroundColor: mainColor, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )),),),
              10.pw,
            ],
          )
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Categories",
              style: TextStylesInter.textViewMedium13,
            ),
          ),
        ),
        SliverToBoxAdapter(child: 20.ph),
        SliverToBoxAdapter(child: const CategorySectionWidget()),
        SliverToBoxAdapter(child: 35.ph),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Products",
              style: TextStylesInter.textViewMedium16,
            ),
          ),
        ),
        SliverToBoxAdapter(child: 22.ph),
        SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: const ProductsGridView()),
      ],
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //
      //   ],
      // ),
    );
  }
}
