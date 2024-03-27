
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Exchange_screen extends StatefulWidget {
  const Exchange_screen({
    super.key
  });

  @override
  State<Exchange_screen> createState() => _Exchange_screenState();
}

class _Exchange_screenState extends State<Exchange_screen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 29.0, right: 29.0,top: 29.0),
      child: Column(
        children: [
          Text("Currency Converter", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
          SizedBox(height: 16,),
          Card(
            
          )
        ],
      ),
    );
  }
}