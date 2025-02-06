import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_ecommerce/core/app_navigator.dart';
import 'package:simple_ecommerce/core/empty_padding.dart';
import 'package:simple_ecommerce/core/widgets/generic_form_field.dart';
import 'package:simple_ecommerce/core/widgets/generic_text_button.dart';
import 'package:simple_ecommerce/features/home/presentation/manager/product_cubit.dart';

import '../../../../../core/style_utils.dart';
import '../../../../../generated/assets.dart';
import '../../../data/models/Product.dart';


class EditProductBottomSheet extends StatefulWidget {
  final Product product;
  const EditProductBottomSheet({super.key, required this.product});

  @override
  State<EditProductBottomSheet> createState() => _EditProductBottomSheetState();
}

class _EditProductBottomSheetState extends State<EditProductBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.product.title!;
    _priceController.text = widget.product.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      30.pw,
                      Text("Edit Product", style: TextStylesInter.textViewBold16,),
                      Spacer(),
                      IconButton(onPressed: (){}, icon: SvgPicture.asset(Assets.iconsClose))
                    ],
                  ),
                  40.ph,
                  Text("Title", style: TextStylesInter.textViewMedium14.copyWith(color: Color(0xff363A42)),),
                  12.ph,
                  GenericFormField(controller: _titleController, validator: (String? value){
                    if(value!.isEmpty){
                      return "Title must not be empty";
                    }
                   if(value.length < 2){
                     return "Title is too short";
                   }
                  }, filled: false, borderColor: Color(0xff1E1E1E33), borderRadius: 6),
                  25.ph,
                  Text("Price", style: TextStylesInter.textViewMedium14.copyWith(color: Color(0xff363A42)),),
                  12.ph,
                  GenericFormField(controller: _priceController, validator: (String? value){
                    if(value!.isEmpty){
                      return "Price must not be empty";
                    }
                    if(double.tryParse(value) == null){
                      return "Price must be number";
                    }
                    if(double.parse(value) <= 0){
                      return "Price must not be zero or a negative number";
                    }
                  }, filled: false, borderColor: Color(0xff1E1E1E33), borderRadius: 6),
                  50.ph,
                ],
              ),
            ),
            // Spacer(),
            30.ph,
           GenericTextButton(text: "Update", onPressed: () async {
             if(_formKey.currentState!.validate()){
               _formKey.currentState!.save();
               var product = widget.product;
               await context.read<ProductCubit>().editProduct(id: product.id!.toInt(), name: _titleController.text.trim(), price: double.parse(_priceController.text.trim()));
               // Fluttertoast.showToast(msg: "Product Updated Successfully");
             AppNavigator.pop(context: context);
             }
           },)
          ],
        ),
      ),
    );
  }
}
