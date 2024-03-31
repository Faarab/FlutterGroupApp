import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/screens/Exchange_screen.dart';

List<DropdownMenuItem<String>> _buildDropdownMenuItems(List<String> items) {
  return items.map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();
}

class DropdownButtonCustom extends StatefulWidget {
  const DropdownButtonCustom({
    super.key,
    required this.listOfChoices,
    required this.onChange,
    required this.startValue,
  });

  final String startValue;
  final List<String> listOfChoices;
  final Function(String) onChange;

  

  @override
  State<DropdownButtonCustom> createState() => _DropdownButtonCustomState();
}

class _DropdownButtonCustomState extends State<DropdownButtonCustom> {

  String _dropdownValue = "";
  List<String> _list = [];

  @override
  void didUpdateWidget(DropdownButtonCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startValue != oldWidget.startValue) {
      setState(() {
        String value = widget.listOfChoices.firstWhere((element) => element.substring(0,3) == widget.startValue);
        _dropdownValue = value;
      });
    }
    if(widget.listOfChoices != oldWidget.listOfChoices){
      setState(() {
        _list = List.from(widget.listOfChoices);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _list = List.from(widget.listOfChoices);
    String value = widget.listOfChoices.firstWhere((element) => element.substring(0,3) == widget.startValue);
    _dropdownValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _dropdownValue,
      icon: const Icon(Icons.expand_more),
      dropdownColor: Colors.white,
      isExpanded: false,
      isDense: false,
      iconSize: 32,
      
      elevation: 8,
      style: const TextStyle(color: Color.fromRGBO(53,16,79,1),fontSize: 20),
      underline: Container(
        height: 2,
        color: Color.fromRGBO(53,16,79,1),
      ),
      onChanged: (String? value) {
        // Trova l'indice del valore selezionato
        setState(() {
          _dropdownValue = value!;
         
        });
        widget.onChange(value!);
      },
      items: _buildDropdownMenuItems(_list),
    );
  }
}