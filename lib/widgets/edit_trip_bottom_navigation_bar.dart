//TODO sistemare bug spinning quando salvo le modifiche dal dialogue essro rimane aperto e non visualizzo lo spinning dietro

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditTripBottomNavigationBar extends StatefulWidget {
  const EditTripBottomNavigationBar({
    super.key,
    required this.onPressed,
  });

  final Function(int) onPressed;

  @override
  State<EditTripBottomNavigationBar> createState() => _EditTripBottomNavigationBarState();
}

class _EditTripBottomNavigationBarState extends State<EditTripBottomNavigationBar> {
  
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (value) {
        widget.onPressed(value);
        _currentIndex = value;
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.info),label: "Details"),
        BottomNavigationBarItem(icon: Icon(Icons.add_location_alt),label:  "Itinerary"),
      ]
    );
  }
}
