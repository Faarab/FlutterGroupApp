
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:triptaptoe_app/services/Api.dart';

import '../widgets/display_currencies.dart';
import '../widgets/dropdown_button_custom.dart';

class Exchange_screen extends StatefulWidget {
  const Exchange_screen({
    super.key
  });

  @override
  State<Exchange_screen> createState() => _Exchange_screenState();
}

class _Exchange_screenState extends State<Exchange_screen> {

  final List<String> _listOfCurrencies = ["USD - US Dollar", "EUR - Euro", "GBP - British Pound"];
  String _conversedValue = "0.00";
  int _indexCurrencyChosen = 0;
  int _indexCurrencyToConvert = 1;
  late String _currencyRate = "";

  @override
  void initState() {
    super.initState();
    _fetchCurrencyRate();
  }

  Future<void> _fetchCurrencyRate() async {
  final String newCurrencyRate = await getCurrencyRateAsync(_listOfCurrencies[_indexCurrencyChosen].substring(0, 3), _listOfCurrencies[_indexCurrencyToConvert].substring(0, 3));
  setState(() {
    _currencyRate = newCurrencyRate;
  });
  print(_currencyRate);
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0,top: 32.0),
      child: Column(
        textDirection: TextDirection.ltr,
        children: [
          Text("Currency Converter", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
          SizedBox(height: 16,),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.58,
            width: MediaQuery.of(context).size.width * 1,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DisplayCurrencies(
                      listOfCurrencies: _listOfCurrencies,
                      text: "From",
                      onChange: (index) {
                        setState(() {
                          _indexCurrencyChosen = index;
                        });
                      },
                      ),
                    SizedBox(height: 8,),
                    Text("1 : ${_currencyRate}", style: TextStyle(fontWeight: FontWeight.w200),),
                    SizedBox(height: 8,),
                    TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      decoration: InputDecoration(
                        hintText: 'Enter the value',
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 18),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^\d{0,10}(?:\.\d{0,2})?$'))
                      ],
                    ),
                    SizedBox(height: 24,),
                    Row(
                      children: [
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(53,16,79,1),
                          ),
                          child: Transform.rotate(
                            angle: -90 * 3.14 / 180,
                            child: IconButton(
                              icon: Icon(Icons.compare_arrows, color: Colors.white, size: 32,),
                              onPressed: () {
                                print(_indexCurrencyToConvert);
                                print(_indexCurrencyChosen);
                              },
                            )
                          ),
                        )
                      ],
                    ),
                    DisplayCurrencies(
                      selectedIndex: _indexCurrencyChosen,
                      listOfCurrencies: _listOfCurrencies,
                      text: "To",
                      onChange: (index) {
                        setState(() {
                          _indexCurrencyToConvert = index;
                        });
                      },
                      ),
                    SizedBox(height: 8,),
                    Text("esempio di conversione", style: TextStyle(fontWeight: FontWeight.w200),),
                    SizedBox(height: 8,),
                    Text(
                      _conversedValue,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}
