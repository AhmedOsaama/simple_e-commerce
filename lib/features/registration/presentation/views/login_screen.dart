import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_ecommerce/core/app_colors.dart';
import 'package:simple_ecommerce/core/empty_padding.dart';
import 'package:simple_ecommerce/core/style_utils.dart';
import 'package:simple_ecommerce/core/widgets/generic_form_field.dart';
import 'package:simple_ecommerce/core/widgets/generic_text_button.dart';
import 'package:simple_ecommerce/core/widgets/my_app_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  105.ph,
                  Text("Welcome", style: TextStylesInter.textViewSemiBold22,),
                  Text("Please enter your data to continue", style: TextStylesInter.textViewRegular15.copyWith(color: Color(0xff8F959E)),),
                  Spacer(
                    flex: 3,
                  ),
                  GenericFormField(controller: _usernameController,label: "Username", validator: (){}, filled: false, borderColor: borderColor, borderRadius: 10),
                  20.ph,
                  GenericFormField(controller: _passwordController,label: "Password", validator: (){}, filled: false, borderColor: borderColor, borderRadius: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(child: Text("Forgot Password?", style: TextStylesInter.textViewRegular15.copyWith(color: Color(0xffEA4335)),), onPressed: (){},),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Remember me"),
                      CupertinoSwitch(value: rememberMe, onChanged: (_){
                        setState(() {
                          rememberMe = !rememberMe;
                        });
                      })
                    ],
                  ),
                  Spacer(flex: 2,),
                  Text("By connecting your account confirm that you agree with our Terms and Condition", textAlign: TextAlign.center,),
                ],
              ),
            ),
          ),
          GenericTextButton(text: "Login", onPressed: (){})
        ],
      ),
    );
  }
}
