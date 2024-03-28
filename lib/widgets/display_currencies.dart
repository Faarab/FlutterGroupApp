import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/widgets/dropdown_button_custom.dart';

class DisplayCurrencies extends StatelessWidget {
  const DisplayCurrencies({
    super.key,
    required this.listOfCurrencies,
    required this.onChange,
    required this.text,
    this.selectedIndex = -1,
  });
  
  final int selectedIndex;
  final String text;
  final Function(int) onChange;
  final List<String> listOfCurrencies;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
        ),
        SizedBox(width: 16,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            Text(text!, style: TextStyle(fontSize: 16,)),
            DropdownButtonCustom(listOfChoices: listOfCurrencies, onChange: onChange, selectedIndex: selectedIndex)
          ],
        ),
      ],
    );
  }
}

