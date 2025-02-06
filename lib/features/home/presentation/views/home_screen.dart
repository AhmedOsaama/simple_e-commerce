import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_ecommerce/core/app_navigator.dart';
import 'package:simple_ecommerce/core/empty_padding.dart';

import '../../../../core/widgets/my_app_bar.dart';
import '../../../../generated/assets.dart';
import '../../../checkout/presentation/views/cart_screen.dart';
import 'widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: SvgPicture.asset(Assets.imagesLogo), actionWidget: [
        IconButton(onPressed: (){
          AppNavigator.push(context: context, screen: const CartScreen());
        }, icon: SvgPicture.asset(Assets.iconsBag), style: IconButton.styleFrom(
          backgroundColor: const Color(0xffF5F6FA)
        ),),
        20.pw,
      ],),
        body: const HomeScreenBody());
  }
}
