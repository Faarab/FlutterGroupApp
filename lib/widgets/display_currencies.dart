import 'package:flutter/material.dart';
import 'package:triptaptoe_app/widgets/dropdown_button_custom.dart';

import 'circle_flag.dart';

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
  late AssetImage _flag;

  void changeFlag( String flag) {
    switch (flag) {
      case "EUR":
        _flag = const AssetImage('assets/images/eu-flag.jfif');
        break;
      case "USD":
        _flag = const AssetImage('assets/images/usa-flag.jfif');
        break;
      case "GBP":
        _flag = const AssetImage('assets/images/uk-flag.jfif');
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    _startValue = widget.startValue;
    changeFlag(_startValue);
  }

  @override
  void didUpdateWidget(DisplayCurrencies oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startValue != oldWidget.startValue) {
      setState(() {
        _startValue = widget.startValue;
        changeFlag(_startValue);
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
        CircleFlag(
          flagImage: _flag,
        ),
        const SizedBox(width: 8,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            Text(widget.text, style: const TextStyle(fontSize: 16,)),
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
