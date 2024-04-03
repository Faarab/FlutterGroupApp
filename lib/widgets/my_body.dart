import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/CityDTO.dart';

import '../screens/add_activity_modal_screen.dart';

class MyBody extends StatefulWidget {
  const MyBody({super.key});

  

  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  final TextEditingController _cityController = TextEditingController();
  final List<CityDTO> _addedCities = [];
  bool _isAddingCity = false;
  late List<CityDTO> hardcodedcitieslist; 

  final List<Map<String, String>> citiesStartingWithMa = [
    {"name": "Madrid", "country": "Spain"},
    {"name": "Málaga", "country": "Spain"},
    {"name": "Manchester", "country": "United Kingdom"},
    {"name": "Malaga", "country": "Spain"},
    {"name": "Malmo", "country": "Sweden"},
  ];
  
  @override
  void initState() {
    super.initState();
    hardcodedcitieslist = citiesStartingWithMa.map((city) => CityDTO(name: city["name"]!, country: city["country"]!)).toList();
  }
  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
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
          _buildDayNavigation(),
          const SizedBox(height: 30),
          if (_isAddingCity || _addedCities.isNotEmpty) _buildAddedCities(),
          const SizedBox(height: 10),
          _buildCityCard(),
        ],
      ),
    );
  }

  Widget _buildDayNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
        const Text("Day 1"),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  Widget _buildAddedCities() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _addedCities.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.radio_button_unchecked),
                    const SizedBox(width: 30),
                    Text(
                      _addedCities[index].name,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ],
                ),
                Row(
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
            icon: const Icon(Icons.add, color: Colors.black,),
            label: const Text("Add a city", style: TextStyle(color: Colors.black),),
          ),
        if (_isAddingCity)
          Row(
            children: [
              Flexible(
                child: Expanded(
                  
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
                        ),
                       
                        onSubmitted: (value) {
                          setState(() {
                            _addedCities.add(CityDTO(name: value));
                            textEditingController.clear();
                            _isAddingCity = false;
                          });
                        },
                      );
                    },
                    optionsViewBuilder: (context, onSelected, cities) {
                      return Material(
                       
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
                        _addedCities.add(city);
                        _cityController.clear();
                        _isAddingCity = false;
                      });
                    },
                  ),
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
