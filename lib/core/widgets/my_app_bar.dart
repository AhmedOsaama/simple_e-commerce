import 'package:flutter/material.dart';

import '../style_utils.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actionWidget;
  const MyAppBar({super.key, this.actionWidget, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      elevation: 0,
      actions: actionWidget,
      centerTitle: true,
      // surfaceTintColor: Colors.white,
      // shadowColor: Colors.black.withOpacity(0.25),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
