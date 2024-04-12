import 'package:flutter/material.dart';

class loadSpinner extends StatelessWidget {
  const loadSpinner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
          height: 80,
          width: 80,
          child: CircularProgressIndicator(
            color: Color.fromRGBO(53, 16, 79, 1),
            strokeWidth: 6,
          ),
        ),
      );
  }
}
