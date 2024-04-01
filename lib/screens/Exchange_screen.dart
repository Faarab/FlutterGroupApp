
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:triptaptoe_app/services/Api.dart';

import '../widgets/black_line_with_opacity.dart';
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

  List<String> _currenciesList = ["USD - US Dollar", "EUR - Euro", "GBP - British Pound"];
  String _convertedValue = "0.00";
  late String _currencyChosen ;
  late String _currencyToConvert;
  late String _exchangeRate = "";
  late String _inverseExchangeRate = "";
  late List<String> _listOfCurrenciesFiltred;
  final myController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _currencyChosen = _currenciesList[0].substring(0, 3);
    _currencyToConvert = _currenciesList[1].substring(0, 3);
    final tempList = _currenciesList;
    _listOfCurrenciesFiltred = List.from(tempList);
    _listOfCurrenciesFiltred.removeWhere((currency) => currency.startsWith(_currencyChosen));
     fetchCurrencyRate();
     
  }

  String convertValue(String value, String conversionRatio ) {

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

  String calculateInverseRate(String exchangeRate) {
    //TODO: fix the exchange rate, it's not working and return a wrong value
    double exchangeRateDouble = double.parse(exchangeRate);
    double inverseExchangeRate = 1 / exchangeRateDouble;
    return inverseExchangeRate.toStringAsFixed(2);
  }
  Future<void> fetchCurrencyRate() async {
    isLoading = true;
    if(_currencyChosen == _currencyToConvert){
      setState(() {
        _exchangeRate = "1";
        _inverseExchangeRate = calculateInverseRate(_exchangeRate);
        isLoading = false;
      });
    } else {
      String newCurrencyRate = await getCurrencyRateAsync(_currencyChosen, _currencyToConvert);
      setState(() {
        _exchangeRate = newCurrencyRate;
        _inverseExchangeRate = calculateInverseRate(_exchangeRate);
        isLoading = false;
      });
    }

    if (myController.text.isNotEmpty) {
      setState(() {
        _convertedValue = convertValue(myController.text, _exchangeRate);
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
                      listOfCurrencies: _currenciesList,
                      text: "From",
                      onChange: (value) {
                        setState(() {
                          if(value.substring(0,3) == _currencyToConvert){
                            _currencyToConvert = _currencyChosen;
                            _currencyChosen = value.substring(0,3);
                            List<String> tempList = List.from(_currenciesList);
                            tempList.removeWhere((currency) => currency.startsWith(_currencyChosen));
                            _listOfCurrenciesFiltred = List.from(tempList);
                            fetchCurrencyRate();
                          } else {
                            _currencyChosen = _currenciesList.firstWhere((element) => element == value).substring(0,3);
                            List<String> tempList = List.from(_currenciesList);
                            tempList.removeWhere((currency) => currency.startsWith(_currencyChosen));
                            _listOfCurrenciesFiltred = List.from(tempList);
                            fetchCurrencyRate();
                          }
                        });
                      },
                      ),
                    SizedBox(height: 8,),
                    Text("1 : ${_exchangeRate}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),),
                    SizedBox(height: 8,),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          _convertedValue = convertValue(value, _exchangeRate);
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
                        BlackLineWithOpacity(),
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
                                  fetchCurrencyRate();
                                  List<String> tempList = List.from(_currenciesList);
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
                          _currencyToConvert = _currenciesList.firstWhere((element) => element == value).substring(0,3);
                          fetchCurrencyRate();
                        });
                      },
                    ),
                    SizedBox(height: 16,),
                    //Text("1 : ${_currencyRatioInverted}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), da sistemare
                    SizedBox(height: 16,),
                    Text(
                      _convertedValue,
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
