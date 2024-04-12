import 'package:flutter/material.dart';

class CircleFlag extends StatelessWidget {
  const CircleFlag({
    super.key,
    required this.flagImage,
  });
  final AssetImage flagImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: flagImage,
           fit: BoxFit.cover
          ),
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
    );
  }
}

