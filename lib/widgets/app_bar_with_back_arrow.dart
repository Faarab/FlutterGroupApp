
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/main.dart';
import 'package:triptaptoe_app/services/navigation.dart';

class AppBarWithBackArrow extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWithBackArrow({
    super.key,
    required this.screen
  });
  final Widget screen;

  @override
  ui.Size get preferredSize => ui.Size.fromHeight(kToolbarHeight);

  @override
  State<AppBarWithBackArrow> createState() => _AppBarWithBackArrowState();
}

class _AppBarWithBackArrowState extends State<AppBarWithBackArrow> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 64,
      backgroundColor: Color.fromRGBO(53,16,79,1),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
        onPressed: () {
          navigateToHomeWithSlideTransition(context);
        },
      ),
    );
  }
}