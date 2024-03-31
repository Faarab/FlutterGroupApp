
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
  late String _currencyRatio = "";
  late String _currencyRatioInverted = "";
  late List<String> _listOfCurrenciesFiltred;
  final myController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _currencyChosen = _listOfCurrencies[0].substring(0, 3);
    _currencyToConvert = _listOfCurrencies[1].substring(0, 3);
    final tempList = _listOfCurrencies;
    _listOfCurrenciesFiltred = List.from(tempList);
    _listOfCurrenciesFiltred.removeWhere((currency) => currency.startsWith(_currencyChosen));
     _fetchCurrencyRate();
     
  }

  String covertValue(String value, String conversionRatio ) {

    try {
      double valueInDouble = double.parse(value);
      double conversionRatioInDouble = double.parse(conversionRatio);
      double convertedValue = valueInDouble * conversionRatioInDouble;
      return convertedValue.toStringAsFixed(2);

    } catch  (e) {
      print("error ${e}");
      return "Error";
    }
  }

  String calculateInverseExchangeRate(String exchangeRate) {
    //TODO: fix the exchange rate, it's not working and return a wrong value
    double exchangeRateDouble = double.parse(exchangeRate);
    double inverseExchangeRate = 1 / exchangeRateDouble;
    return inverseExchangeRate.toStringAsFixed(2);
  }
  Future<void> _fetchCurrencyRate() async {
    isLoading = true;
    print("parte la request");
    if(_currencyChosen == _currencyToConvert){
      setState(() {
        _currencyRatio = "1";
        _currencyRatioInverted = calculateInverseExchangeRate(_currencyRatio);
        isLoading = false;
      });
    } else {
      String newCurrencyRate = await getCurrencyRateAsync(_currencyChosen, _currencyToConvert);
      setState(() {
        _currencyRatio = newCurrencyRate;
        _currencyRatioInverted = calculateInverseExchangeRate(_currencyRatio);
        isLoading = false;
      });
    }

    if (myController.text.isNotEmpty) {
      setState(() {
        _conversedValue = covertValue(myController.text, _currencyRatio);
      });
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
              child: 
              isLoading ?
              Center(
                child: Container(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(53,16,79,1),
                    strokeWidth: 6,
                  ),
                ),
              ) :  
              Padding(
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
                            
                            tempList.removeWhere((currency) => currency.startsWith(_currencyChosen));
                            
                            _listOfCurrenciesFiltred = List.from(tempList);
                            
                            _fetchCurrencyRate();
                          } else {
                            _currencyChosen = _listOfCurrencies.firstWhere((element) => element == value).substring(0,3);
                            List<String> tempList = List.from(_listOfCurrencies);
                            
                            tempList.removeWhere((currency) => currency.startsWith(_currencyChosen));
                            
                            _listOfCurrenciesFiltred = List.from(tempList);
                            
                            _fetchCurrencyRate();
                          }
                        });
                      },
                      ),
                    SizedBox(height: 8,),
                    Text("1 : ${_currencyRatio}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),),
                    SizedBox(height: 8,),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          _conversedValue = covertValue(value, _currencyRatio);
                        });
                      },
                      controller: myController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      decoration: InputDecoration(
                        hintText: '0.00',
                        hintStyle: TextStyle(color: const Color.fromARGB(255, 84, 75, 75),fontSize: 24),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^\d{0,10}(?:\.\d{0,2})?$'))//regex che prende solo 10 cifre
                      ],
                    ),
                    SizedBox(height: 24,),
                    Row(
                      children: [
                        Container(
                          height: 2,
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(53,16,79,1),
                          ),
                          child: Transform.rotate(
                            angle: -90 * 3.14 / 180,
                            child: IconButton(
                              icon: Icon(Icons.compare_arrows, color: Colors.white, size: 40,),
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
                    SizedBox(height: 16,),
                    //Text("1 : ${_currencyRatioInverted}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), da sistemare
                    SizedBox(height: 16,),
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