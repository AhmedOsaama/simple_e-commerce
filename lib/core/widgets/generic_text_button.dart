import 'package:flutter/material.dart';

import '../style_utils.dart';


class GenericTextButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const GenericTextButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextButton(onPressed: () => onPressed(),
          style: TextButton.styleFrom(backgroundColor: Color(0xff9775FA),
            shape: RoundedRectangleBorder(),
            fixedSize: Size.fromWidth(double.maxFinite),
          ),
          child: Text(text, style: TextStylesInter.textViewMedium17.copyWith(color: Color(0xffFEFEFE)),)),
    );
  }
}
