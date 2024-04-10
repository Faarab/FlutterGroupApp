//TODO sistemare bug spinning quando salvo le modifiche dal dialogue essro rimane aperto e non visualizzo lo spinning dietro

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/screens/edit_trip_screen.dart';

class EditTripFloatingActionButton extends StatefulWidget {
  final Function() onPressed;
  const EditTripFloatingActionButton({
    super.key,
    required this.onPressed,
  });

  @override
  _EditTripFloatingActionButtonState createState() => _EditTripFloatingActionButtonState();
}

class _EditTripFloatingActionButtonState extends State<EditTripFloatingActionButton> {
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        if (!isSaving) {
          setState(() {
            isSaving = true;
          });

          await widget.onPressed();

          setState(() {
            isSaving = false;
          });
        }
      },
      backgroundColor: const Color.fromRGBO(53, 16, 79, 1),
      shape: const CircleBorder(), 
      child: isSaving 
        ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
        : const Icon(Icons.save, color: Colors.white),
    );
  }
}