
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

  List<String> _listOfCurrencies = ["USD - US Dollar", "EUR - Euro", "GBP - British Pound"];
  String _conversedValue = "0.00";
  late String _currencyChosen ;
  late String _currencyToConvert;
  late String _currencyRate = "";
  late List<String> _listOfCurrenciesFiltred;

  @override
  void initState() {
    super.initState();
    _fetchCurrencyRate();
    _currencyChosen = _listOfCurrencies[0].substring(0, 3);
    _currencyToConvert = _listOfCurrencies[1].substring(0, 3);
    final tempList = _listOfCurrencies;
    _listOfCurrenciesFiltred = List.from(tempList);
    _listOfCurrenciesFiltred.removeWhere((currency) => currency.startsWith(_currencyChosen));
  }

  Future<void> _fetchCurrencyRate() async {
    if(_currencyChosen == _currencyToConvert){
      setState(() {
        _currencyRate = "1";
      });
    } else {
      String newCurrencyRate = await getCurrencyRateAsync(_currencyChosen, _currencyToConvert);
      setState(() {
        _currencyRate = newCurrencyRate;
      });
      print(_currencyRate);
    }
    
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
                      startValue: _currencyChosen,
                      listOfCurrencies: _listOfCurrencies,
                      text: "From",
                      onChange: (value) {
                        setState(() {
                          if(value.substring(0,3) == _currencyToConvert){
                            _currencyToConvert = _currencyChosen;
                            _currencyChosen = value.substring(0,3);
                            List<String> tempList = List.from(_listOfCurrencies);
                            print(tempList);
                            tempList.removeWhere((currency) => currency.startsWith(_currencyChosen));
                            print(tempList);
                            _listOfCurrenciesFiltred = List.from(tempList);
                            print(_listOfCurrenciesFiltred);
                            _fetchCurrencyRate();
                          } else {
                            _currencyChosen = _listOfCurrencies.firstWhere((element) => element == value).substring(0,3);
                            List<String> tempList = List.from(_listOfCurrencies);
                            print(tempList);
                            tempList.removeWhere((currency) => currency.startsWith(_currencyChosen));
                            print(tempList);
                            _listOfCurrenciesFiltred = List.from(tempList);
                            print(_listOfCurrenciesFiltred);
                            _fetchCurrencyRate();
                          }
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
                                setState(() {
                                  String temp = _currencyToConvert;
                                  _currencyToConvert = _currencyChosen;
                                  _currencyChosen = temp;
                                  _fetchCurrencyRate();
                                  List<String> tempList = List.from(_listOfCurrencies);
                                  tempList.removeWhere((currency) => currency.startsWith(_currencyChosen));
                                  _listOfCurrenciesFiltred = List.from(tempList);
                                });
                              },
                            )
                          ),
                        )
                      ],
                    ),
                    DisplayCurrencies(
                      listOfCurrencies: _listOfCurrenciesFiltred,
                      text: "To",
                      startValue: _currencyToConvert,
                      onChange: (value) {
                        setState(() {
                          _currencyToConvert = _listOfCurrencies.firstWhere((element) => element == value).substring(0,3);
                          _fetchCurrencyRate();
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