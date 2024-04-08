// da fare:
// fare in modo che la parte di aggiunta delle città sia scorrevole e che quando si apre la tastiera non dia errore di spazio. + sistemare aggiunta manuale
// implementare logica per salvare dati inseriti da utente
// implementare logica per aggiungere attività scelta da utente
// sistemare font, colori e size
//scorrimento tra giorni fatto, mancano le date di fianco al giorno e sistemare total days perché è hardcoded

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:triptaptoe_app/models/CityDTO.dart';
import '../screens/add_activity_modal_screen.dart';
import 'days_navigation.dart';

final List<Map<String, String>> citiesStartingWithMa = [
  {"name": "Barcelona", "country": "Spain"},
  {"name": "Seville", "country": "Spain"},
  {"name": "Valencia", "country": "Spain"},
  {"name": "Bilbao", "country": "Spain"},
  {"name": "Granada", "country": "Spain"},
  {"name": "London", "country": "United Kingdom"},
  {"name": "Birmingham", "country": "United Kingdom"},
  {"name": "Glasgow", "country": "United Kingdom"},
  {"name": "Liverpool", "country": "United Kingdom"},
  {"name": "Edinburgh", "country": "United Kingdom"}
  
];

class MyBody extends StatefulWidget {
  const MyBody({super.key});

  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  final TextEditingController _cityController = TextEditingController();
  bool _isAddingCity = false;
  late List<CityDTO> hardcodedcitieslist;

  //rappresenta le città per ogni giorno, impostato hardcoded da CAMBIARE!
  late List<List<CityDTO>> _citiesPerDay = List.generate(10, (_) => []);


  int _currentDayIndex = 0; 

  void _goToPreviousDay(int newIndex) {
    setState(() {
      _currentDayIndex = newIndex;
    });
  }

  void _goToNextDay(int newIndex) {
    setState(() {
      _currentDayIndex = newIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    hardcodedcitieslist =
        citiesStartingWithMa.map((city) => CityDTO(name: city["name"]!, country: city["country"]!)).toList();
    
    _citiesPerDay = List.generate(10, (_) => []);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 29, right: 29),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text(
            "Edit Itinerary",
            style: TextStyle(
              color: Color.fromRGBO(45, 45, 45, 1),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          DaysNavigation(
            dayIndex: _currentDayIndex,
            totalDays: 10,
            onBackward: _goToPreviousDay,
            onForward: _goToNextDay,
          ),
          const SizedBox(height: 30),
          if (_isAddingCity || _citiesPerDay[_currentDayIndex].isNotEmpty) SingleChildScrollView(child: _buildAddedCities()),
          const SizedBox(height: 10),
          _buildCityCard(),
        ],
      ),
    );
  }

  Widget _buildAddedCities() {
    final currentCities = _citiesPerDay[_currentDayIndex];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: currentCities.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                   
                Text(
                  currentCities[index].name, 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(width: 24),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Color.fromRGBO(53, 16, 79, 1)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            content: const Text("Do you want to delete this city?"),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: TextButton(
                                       style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(53, 16, 79, 1)),
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel", style: TextStyle(color: Colors.white),),
                                     
                                    ),
                                  ),
                                  const SizedBox(width: 20.0),
                                  SizedBox(
                                    width: 120,
                                    child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(53, 16, 79, 1)),
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                      ),
                                      onPressed: () {
                                              setState(() {
                                                _citiesPerDay[_currentDayIndex].removeAt(index);
                                              });
                                              Navigator.of(context).pop();
                                            },
                                      child: const Text("Delete",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      );
                    },
                   
                  ),
                ],
                ),
                const Row(
                  children: [
                    AddActivityModal(),
                  ],
                )
               
              ],
            ),
          ],
        );
      },
    );
  }


  Widget _buildCityCard() {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          if (!_isAddingCity)
            TextButton.icon(
  onPressed: () {
    setState(() {
      _isAddingCity = true;
    });
  },
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.white), 
    
    minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
    shape: MaterialStateProperty.all(
    const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero, 
    ),
  ),
    alignment: Alignment.centerLeft
  ),
  
  icon: const Icon(Icons.add, color: Colors.black),
  label: const Text("Add a city", style: TextStyle(color: Colors.black)),
),


          if (_isAddingCity)
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  
                  child: Autocomplete<CityDTO>(
                    optionsBuilder: (textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<CityDTO>.empty();
                      } else {
                        return hardcodedcitieslist.where((CityDTO city) {
                          return city.name.toLowerCase().startsWith(textEditingValue.text.toLowerCase());
                        });
                      }
                    },
                    fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted){
                      return TextField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          hintText: 'Enter a city',
                          filled: true,
                          fillColor: Colors.transparent,                        
                        ),
                        
                        onSubmitted: (value) {
                          final selectedCity = hardcodedcitieslist.firstWhereOrNull((city) => city.name == value);
                          if (selectedCity != null) {
                            setState(() {
                              _citiesPerDay[_currentDayIndex].add(selectedCity);
                              textEditingController.clear();
                              _isAddingCity = false;
                            });
                          }
                        },
                      );
                    },
                    optionsViewBuilder: (context, onSelected, cities) {
                      return Material(
                        color: Colors.transparent,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10,),
                          itemCount: cities.length,
                          itemBuilder: (BuildContext context, int index){
                            final city = cities.elementAt(index);
                            return ListTile(
                              leading: const Icon(Icons.location_on),
                              title: Text(city.name, ),
                              subtitle: Text(city.country?? 'N/A'),
                              onTap: () {
                                onSelected(city);
                              },
                            );
                          },
                        ),
                      );
                    },
                    onSelected: (CityDTO city) {
                      setState(() {
                        _citiesPerDay[_currentDayIndex].add(city);
                        _cityController.clear();
                        _isAddingCity = false;
                      });
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isAddingCity = false;
                    });
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
        ],
      ), 
    );
  }
}
