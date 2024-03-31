import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/widgets/dropdown_button_custom.dart';

class DisplayCurrencies extends StatefulWidget {
  const DisplayCurrencies({
    super.key,
    required this.listOfCurrencies,
    required this.onChange,
    required this.text,
    required this.startValue,
    
  });
  
  final String startValue;
  final String text;
  final Function(String) onChange;
  final List<String> listOfCurrencies;

  @override
  State<DisplayCurrencies> createState() => _DisplayCurrenciesState();
}

class _DisplayCurrenciesState extends State<DisplayCurrencies> {
  
  late List<String> _list = widget.listOfCurrencies; 
  late String _startValue ;

  @override
  void initState() {
    super.initState();
    _startValue = widget.startValue;
  }

  @override
  void didUpdateWidget(DisplayCurrencies oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startValue != oldWidget.startValue) {
      setState(() {
        _startValue = widget.startValue;
      });
    }

    if (widget.listOfCurrencies != oldWidget.listOfCurrencies) {
      setState(() {
        _list = widget.listOfCurrencies;
      });
    }
  }

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
            Text(widget.text!, style: TextStyle(fontSize: 16,)),
            DropdownButtonCustom(
              startValue: _startValue,
              listOfChoices: _list, 
              onChange: (value) {
                widget.onChange(value);
              },
            )
          ],
        ),
      ],
    );
  }
}

