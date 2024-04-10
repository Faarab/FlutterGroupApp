//TODO sistemare bug spinning quando salvo le modifiche dal dialogue essro rimane aperto e non visualizzo lo spinning dietro

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogEditTrip extends StatefulWidget {
  const DialogEditTrip({
      Key? key,
      required this.onPressed,
    });

  final Function(bool) onPressed;


  @override
  State<DialogEditTrip> createState() => _DialogEditTripState();
}

class _DialogEditTripState extends State<DialogEditTrip> {
  final String contentText =
      "Changing this section will permanently erase all your changes. You will lose any unsaved information.\nDo you want to proceed?";
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      insetAnimationDuration: const Duration(milliseconds: 100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      actions: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child : TextButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(const BorderSide(color: Color.fromRGBO(53, 16, 79, 1))),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    )
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel",style: TextStyle(color: Color.fromRGBO(53, 16, 79, 1),fontWeight: FontWeight.bold,fontSize: 18)),
                ),
              ),
              const SizedBox(width: 20.0),
              SizedBox(
                width: 120,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(53, 16, 79, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    )
                  ),
                  onPressed: () async {
                    widget.onPressed(true);
                    Navigator.pop(context);
                  },
                  child: const Text("Continue",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                ),
              ),
            ],
          ),
      ],
      content: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Warning!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(contentText,textAlign: TextAlign.center,style: const TextStyle(fontSize: 20.0),),
          ],
        ),
      ),
    );
  }
}