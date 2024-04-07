import 'package:flutter/material.dart';

class DaysNavigation extends StatelessWidget {
  const DaysNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
        const Text("Day 1"),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
