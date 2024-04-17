
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:triptaptoe_app/services/Api.dart';
import 'black_line_with_opacity.dart';
import 'display_currencies.dart';
import 'load_spinner.dart';

class ExchangeBody extends StatefulWidget {
  const ExchangeBody({super.key});

  @override
  State<ExchangeBody> createState() => _ExchangeBodyState();
}

class _ExchangeBodyState extends State<ExchangeBody> {
  final List<String> _currenciesList = [
    "USD - US Dollar",
    "EUR - Euro",
    "GBP - British Pound"
  ];
  String _convertedValue = "0.00";
  late String _currencyChosen;
  late String _currencyToConvert;
  late String _exchangeRate = "";
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
    _listOfCurrenciesFiltred
        .removeWhere((currency) => currency.startsWith(_currencyChosen));
    fetchCurrencyRate();
  }

  String convertValue(String value, String conversionRatio) {
    try {
      double valueInDouble = double.parse(value);
      double conversionRatioInDouble = double.parse(conversionRatio);
      double convertedValue = valueInDouble * conversionRatioInDouble;
      return convertedValue.toStringAsFixed(2);
    } catch (e) {
      return "Error";
    }
  }

  Future<void> fetchCurrencyRate() async {
    if (!mounted) return; // Verifica se lo stato del widget è ancora montato

    setState(() {
      isLoading = true;
    });

    if (_currencyChosen == _currencyToConvert) {
      setState(() {
        _exchangeRate = "1";
        isLoading = false;
      });
    } else {
      String newCurrencyRate =
          await getCurrencyRateAsync(_currencyChosen, _currencyToConvert);
      if (!mounted) return;
      setState(() {
        _exchangeRate = newCurrencyRate;
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
      padding: const EdgeInsets.only(left: 29.0, right: 29.0, top: 32.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Currency Converter",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.58,
              width: MediaQuery.of(context).size.width * 1,
              child: Card(
                  elevation: 4,
                  child: isLoading
                      ? const loadSpinner()
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DisplayCurrencies(
                                startValue: _currencyChosen,
                                listOfCurrencies: _currenciesList,
                                text: "From",
                                onChange: (value) {
                                  setState(() {
                                    if (value.substring(0, 3) ==
                                        _currencyToConvert) {
                                      _currencyToConvert = _currencyChosen;
                                      _currencyChosen = value.substring(0, 3);
                                      List<String> tempList =
                                          List.from(_currenciesList);
                                      tempList.removeWhere((currency) =>
                                          currency.startsWith(_currencyChosen));
                                      _listOfCurrenciesFiltred =
                                          List.from(tempList);
                                      fetchCurrencyRate();
                                    } else {
                                      _currencyChosen = _currenciesList
                                          .firstWhere(
                                              (element) => element == value)
                                          .substring(0, 3);
                                      List<String> tempList =
                                          List.from(_currenciesList);
                                      tempList.removeWhere((currency) =>
                                          currency.startsWith(_currencyChosen));
                                      _listOfCurrenciesFiltred =
                                          List.from(tempList);
                                      fetchCurrencyRate();
                                    }
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  "1 $_currencyChosen = ${_exchangeRate.substring(0, 4)} $_currencyToConvert",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300, fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextField(
                                strutStyle: const StrutStyle(),
                                onChanged: (value) {
                                  setState(() {
                                    _convertedValue =
                                        convertValue(value, _exchangeRate);
                                  });
                                },
                                controller: myController,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                ],
                                style:const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                                    decoration: const InputDecoration(
                                      hintText: '0.00',
                                      contentPadding: EdgeInsets.only(left: 8),
                                      hintStyle: TextStyle(
                                          color:  Color.fromARGB(
                                              255, 84, 75, 75),
                                          fontSize: 24),
                                      border: UnderlineInputBorder()
                                    ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                children: [
                                  const BlackLineWithOpacity(),
                                  Container(
                                    height: 56,
                                    width: 56,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(53, 16, 79, 1),
                                    ),
                                    child: Transform.rotate(
                                        angle: -90 * 3.14 / 180,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.compare_arrows,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              String temp = _currencyToConvert;
                                              _currencyToConvert =
                                                  _currencyChosen;
                                              _currencyChosen = temp;
                                              fetchCurrencyRate();
                                              List<String> tempList =
                                                  List.from(_currenciesList);
                                              tempList.removeWhere((currency) =>
                                                  currency.startsWith(
                                                      _currencyChosen));
                                              _listOfCurrenciesFiltred =
                                                  List.from(tempList);
                                            });
                                          },
                                        )),
                                  )
                                ],
                              ),
                              DisplayCurrencies(
                                listOfCurrencies: _listOfCurrenciesFiltred,
                                text: "To",
                                startValue: _currencyToConvert,
                                onChange: (value) {
                                  setState(() {
                                    _currencyToConvert = _currenciesList
                                        .firstWhere(
                                            (element) => element == value)
                                        .substring(0, 3);
                                    fetchCurrencyRate();
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              //Text("1 : ${_currencyRatioInverted}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),), da sistemare
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                _convertedValue,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )),
            )
          ],
        ),
      ),
    );
  }
}
