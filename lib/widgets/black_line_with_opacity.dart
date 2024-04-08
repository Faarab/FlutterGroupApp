import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlackLineWithOpacity extends StatelessWidget {
  const BlackLineWithOpacity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
      ),
    );
  }
}