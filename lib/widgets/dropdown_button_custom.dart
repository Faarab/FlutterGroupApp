import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/screens/Exchange_screen.dart';

class DropdownButtonCustom extends StatefulWidget {
  const DropdownButtonCustom({
    super.key,
    required this.listOfChoices,
    required this.onChange,
    this.selectedIndex = -1,
  });

  final int selectedIndex;
  final List<String> listOfChoices;
  final Function(int) onChange;

  

  @override
  State<DropdownButtonCustom> createState() => _DropdownButtonCustomState();
}

class _DropdownButtonCustomState extends State<DropdownButtonCustom> {

  late Int _selectedIndex ;
  String _dropdownValue = "";
  List<String> _list = [];
  @override
  void initState() {
    super.initState();
    _list = widget.listOfChoices;
    /*
    if(widget.selectedIndex != -1){ 
      widget.listOfChoices.remove(widget.listOfChoices[widget.selectedIndex]);
      _list = widget.listOfChoices;
    } else {
      _list = widget.listOfChoices;
    }*/
    _dropdownValue = widget.listOfChoices.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _dropdownValue,
      icon: const Icon(Icons.arrow_downward_sharp),
      elevation: 8,
      style: const TextStyle(color: Colors.deepPurple,fontSize: 20),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        final index = _list.indexOf(value!); // Trova l'indice del valore selezionato
        setState(() {
          _dropdownValue = value;
        });
        widget.onChange(index);
      },
      items: _list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}