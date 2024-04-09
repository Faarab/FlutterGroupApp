import 'dart:ui' as ui ;
import 'package:flutter/material.dart';

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

  String _selectedValue = "";
  List<String> _choicesList = [];

  @override
  void didUpdateWidget(DropdownButtonCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startValue != oldWidget.startValue) {
      setState(() {
        String value = widget.listOfChoices.firstWhere((element) => element.substring(0,3) == widget.startValue);
        _selectedValue = value;
      });
    }
    if(widget.listOfChoices != oldWidget.listOfChoices){
      setState(() {
        _choicesList = List.from(widget.listOfChoices);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _choicesList = List.from(widget.listOfChoices);
    String value = widget.listOfChoices.firstWhere((element) => element.substring(0,3) == widget.startValue);
    _selectedValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(

      initialSelection: _selectedValue,
      width: 200,
      inputDecorationTheme: InputDecorationTheme(
        disabledBorder: const InputDecoration().disabledBorder,
      ),
      textStyle: const TextStyle(fontSize: 20,fontWeight: ui.FontWeight.bold),
      onSelected: (value) {
        setState(() {
          _selectedValue = value!;
        });
        widget.onChange(value!);
      },
      dropdownMenuEntries: _choicesList.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(
          value: value,
          label: value,
        );
      }).toList(),
    );
  }
}