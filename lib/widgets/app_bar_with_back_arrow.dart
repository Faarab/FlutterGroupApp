import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:triptaptoe_app/main.dart';
import 'package:triptaptoe_app/services/navigation.dart';

class AppBarWithBackArrow extends StatefulWidget
    implements PreferredSizeWidget {
  const AppBarWithBackArrow({
    super.key, 
    this.title
  });
  
  final String? title;

  @override
  ui.Size get preferredSize => const ui.Size.fromHeight(kToolbarHeight);

  @override
  State<AppBarWithBackArrow> createState() => _AppBarWithBackArrowState();
}

class _AppBarWithBackArrowState extends State<AppBarWithBackArrow> {
  @override
  Widget build(BuildContext context) {
    late double fontSizeOfTitle;
    if(widget.title != null) {
      if(widget.title!.length > 10) {
        fontSizeOfTitle = 24;
      } else {
        fontSizeOfTitle = 32;
      }
    }
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      toolbarHeight: 64,
      title: widget.title != null ? Text(widget.title!, style: TextStyle(fontSize: fontSizeOfTitle, fontWeight: FontWeight.bold, color: Colors.white)) : null,
      backgroundColor: const Color.fromRGBO(53, 16, 79, 1),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          navigateToHomeWithSlideTransition(context);
        },
      ),
    );
  }
}
