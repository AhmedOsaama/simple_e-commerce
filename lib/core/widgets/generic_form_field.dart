import 'package:flutter/material.dart';

import '../style_utils.dart';

class GenericFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final bool? obscurePassword;
  final Widget? suffixIcon;
  final String? label;
  final bool filled;
  final Color borderColor;
  final double borderRadius;
  final bool readonly;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Function(String)? onChanged;
  final bool? enabled;
  const GenericFormField(
      {super.key,
      required this.controller,
      required this.validator,
      this.obscurePassword,
      this.suffixIcon,
      this.label,
      required this.filled,
      required this.borderColor,
      required this.borderRadius,
      this.readonly = false,
      this.enabled, this.hintText, this.hintStyle, this.onChanged, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => validator(value),
      obscureText: obscurePassword ?? false,
      style: TextStylesInter.textViewRegular16,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onChanged: onChanged,
      readOnly: readonly,
      maxLines: maxLines,
      enabled: enabled,
      decoration: InputDecoration(
          label: label != null
              ? Text(
                  label!,
                  style: TextStylesInter.textViewRegular10.copyWith(fontSize: 12),
                )
              : null,
          isDense: true,
          errorMaxLines: 3,
          hintText: hintText,
          hintStyle: hintStyle,
          filled: filled,
          suffixIcon: suffixIcon,
          fillColor: const Color(0xffE5E5E5),
          border: OutlineInputBorder(
              // borderSide: const BorderSide(color: Color(0xff8CC63E)),
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(borderRadius)),
          enabledBorder: OutlineInputBorder(
              // borderSide: BorderSide(color: Color(0xff8CC63E)),
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(borderRadius)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffC6523E)),
              borderRadius: BorderRadius.circular(borderRadius))),
    );
  }
}
