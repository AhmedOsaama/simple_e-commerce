import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:simple_ecommerce/core/app_colors.dart';
import 'package:simple_ecommerce/core/app_navigator.dart';
import 'package:simple_ecommerce/core/empty_padding.dart';
import 'package:simple_ecommerce/core/widgets/generic_form_field.dart';
import 'package:simple_ecommerce/features/home/presentation/views/home_screen.dart';

import '../../../../core/style_utils.dart';
import '../../../../core/widgets/generic_text_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailAddressController = TextEditingController();
  bool rememberMe = false;

  bool isRegistering = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        progressIndicator: CupertinoActivityIndicator(),
        inAsyncCall: isRegistering,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      105.ph,
                      Text("Sign up", style: TextStylesInter.textViewSemiBold22),
                      Spacer(),
                      GenericFormField(
                        label: "Username",
                          controller: _usernameController, validator: (){}, filled: false, borderColor: borderColor, borderRadius: 10),
                      10.ph,
                      GenericFormField(
                          label: "Password",
                          controller: _passwordController, validator: (){}, filled: false, borderColor: borderColor, borderRadius: 10),
                      10.ph,
                      GenericFormField(
                        label: "Email Address",
                          controller: _emailAddressController, validator: (){}, filled: false, borderColor: borderColor, borderRadius: 10),
                      30.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Remember me",),
                          CupertinoSwitch(value: rememberMe, onChanged: (_){
                            setState(() {
                              rememberMe = !rememberMe;
                            });
                          })
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              GenericTextButton(text: "Sign Up", onPressed: () async {
                setState(() {
                  isRegistering = true;
                });
                await Future.delayed(Duration(seconds: 1),);
                AppNavigator.pushReplacement(context: context, screen: HomeScreen());
              })
            ],
          ),
        ),
      ),
    );
  }
}
