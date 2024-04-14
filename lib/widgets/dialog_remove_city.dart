import 'package:flutter/material.dart';

class DialogRemoveCity extends StatelessWidget {


  DialogRemoveCity({
    required this.onCityRemoved,
    required this.cityIndex,
  });

  final Function(int) onCityRemoved;
  final int cityIndex;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: const Text("Do you want to delete this city?"),
      actions: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(53, 16, 79, 1)),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                SizedBox(
                  width: 120,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(53, 16, 79, 1)),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    onPressed: () {
                      onCityRemoved(cityIndex);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Delete",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
