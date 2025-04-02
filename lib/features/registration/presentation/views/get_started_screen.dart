import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_ecommerce/core/app_navigator.dart';
import 'package:simple_ecommerce/core/empty_padding.dart';
import 'package:simple_ecommerce/core/style_utils.dart';
import 'package:simple_ecommerce/core/widgets/generic_text_button.dart';
import 'package:simple_ecommerce/features/registration/presentation/views/login_screen.dart';
import 'package:simple_ecommerce/features/registration/presentation/views/register_screen.dart';
import 'package:simple_ecommerce/generated/assets.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          105.ph,
          Text("Let's Get Started", style: TextStylesInter.textViewSemiBold22.copyWith(fontSize: 28),),
          Spacer(),
          SvgPicture.asset(Assets.imagesLogo, width: 100,),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Text("Already have an account?", style: TextStylesInter.textViewRegular15.copyWith(color: Color(0xff8F959E)),),
             TextButton(onPressed: (){
                AppNavigator.push(context: context, screen: LoginScreen());
             }, child: Text("Sign in"))
            ],
          ),
          GenericTextButton(text: "Create an account", onPressed: () => AppNavigator.push(context: context, screen: RegisterScreen())),
        ],
      ),
    );
  }
}
