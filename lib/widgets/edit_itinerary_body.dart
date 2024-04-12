import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:triptaptoe_app/models/ActivityDTO.dart';
import 'package:triptaptoe_app/models/CityDTO.dart';
import 'package:triptaptoe_app/screens/edit_itinerary_screen.dart';
import 'package:triptaptoe_app/widgets/change_day_itinerary.dart';
import '../screens/add_activity_modal_screen.dart';
import 'package:intl/intl.dart';

//TODO ricordarsi di sistemare il fatto che se cancello una città quando la ricreo l'attività rimane

final List<Map<String, dynamic>> citiesStartingWithMa = [
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

class EditItineraryBody extends StatefulWidget {
  const EditItineraryBody({super.key, required this.widget});

  final EditItineraryScreen widget;

  @override
  State<EditItineraryBody> createState() => _EditItineraryBodyState();
}

class _EditItineraryBodyState extends State<EditItineraryBody> {
  final TextEditingController _cityController = TextEditingController();
  bool _isAddingCity = false;
  late List<CityDTO> hardcodedcitieslist;
  List<ActivityDTO> activities = [];
  late int _currentDayIndex;
  late bool _canGoBackward;
  late bool _canGoForward;
  final ScrollController _scrollController = ScrollController();
  late List<List<CityDTO>> _citiesPerDay =[];
  CityDTO? _selectedCity;
  

void _onActivityAdded(ActivityDTO activity) {
  setState(() {
    if (_selectedCity != null) {
      int cityIndex = _citiesPerDay[_currentDayIndex].indexOf(_selectedCity!);
      if (cityIndex != -1) {
        if (_citiesPerDay[_currentDayIndex][cityIndex].activities != null) {
          int insertIndex = 0;
          for (int i = 0; i < _citiesPerDay[_currentDayIndex][cityIndex].activities!.length; i++) {
            if (activity.startTime.isBefore(_citiesPerDay[_currentDayIndex][cityIndex].activities![i].startTime)) {
              insertIndex = i;
              break;
            } else {
              insertIndex = i + 1;
            }
          }
          _citiesPerDay[_currentDayIndex][cityIndex].activities!.insert(insertIndex, activity);
        } else {
          
          _citiesPerDay[_currentDayIndex][cityIndex].activities = [activity];
        }
      }
    }
  });
}


  @override
  void initState() {
    super.initState();
    hardcodedcitieslist =
        citiesStartingWithMa.map((city) => CityDTO(name: city["name"]!, country: city["country"]!)).toList();
      

   _currentDayIndex = 0;
    _canGoBackward = false;
    if (widget.widget.trip.days!.length > 1) {
      _canGoForward = true;
    } else {
      _canGoForward = false;
    }
    _citiesPerDay = List.generate(widget.widget.trip.days!.length, (_) => []);
  }

  @override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 29, right: 29),
    child: SingleChildScrollView( 
      controller: _scrollController,
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
          ChangeDayItinerary(
            widget: widget,
            day: widget.widget.trip.days![_currentDayIndex],
            canGoBackward: _canGoBackward,
            canGoForward: _canGoForward,
            dayIndex: _currentDayIndex,
            onBackward: () {
              setState(() {
                if (_currentDayIndex > 0) {
                  _currentDayIndex--;
                  _canGoForward = true;
                  _scrollController.animateTo(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                }
                if (_currentDayIndex == 0) {
                  _canGoBackward = false;
                }
              });
            },
            onForward: () {
              setState(() {
                if (_currentDayIndex < widget.widget.trip.days!.length - 1) {
                  _currentDayIndex++;
                  _canGoBackward = true;
                  _scrollController.animateTo(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                }
                if (_currentDayIndex == widget.widget.trip.days!.length - 1) {
                  _canGoForward = false;
                }
              });
            },
          ),
          const SizedBox(height: 30),
          if (_isAddingCity || _citiesPerDay[_currentDayIndex].isNotEmpty) _buildAddedCities(),
          const SizedBox(height: 10),
          _buildCityCard(),
        ],
      ),
    ),
  );
}

  Widget _buildAddedActivities() {
    
    return ListView.builder(
      shrinkWrap: true,
      itemCount: activities.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
  title: Row(
    children: [
      Text(activities[index].name),
      const SizedBox(width: 8), 
      Text(DateFormat('HH:mm').format(activities[index].startTime)),
    ],
  ),
);

      },
    );
  }

  Widget _buildAddedCities() {
  final currentCities = _citiesPerDay[_currentDayIndex];
  if (currentCities.isEmpty) {
    return Container(); 
  }

  return ListView.separated(
    shrinkWrap: true,
    itemCount: currentCities.length,
    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
    itemBuilder: (BuildContext context, int index) {
      final city = currentCities[index];
      return Column(
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
                          Column(
                            children: [
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
          Container(
  
            height: city.activities?.isNotEmpty ?? false ? null : 0,

            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: city.activities?.length,
              itemBuilder: (BuildContext context, int activityIndex) {
                final activity = city.activities?[activityIndex];
                return Card(
                  
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                      children: [
                        Text(
                          city.activities != null && index < city.activities!.length
                              ? city.activities![index].name
                              : 'no city no party',
                          style: const TextStyle(fontSize: 16),
                        ),

                        Text(
                          city.activities != null && activityIndex < city.activities!.length
                              ? '${city.activities![activityIndex].startTime.hour}:${city.activities![activityIndex].startTime.minute}'
                              : '',
                        )

                      ],
                    ),
                  ),
                );
              },
            ),
          ),


          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:16.0),
                child: TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Add an activity"),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => AddActivityModal(onActivityAdded: _onActivityAdded, selectedCity: _selectedCity,),
                    );
                  },
                ),
              ),
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
            Row(
  children: [
    Expanded(
      child: TextButton.icon(
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
        label: const Text("Add a city", style: TextStyle(color: Colors.black)),
        icon: const Icon(Icons.add, color: Colors.black),
      ),
    ),
  ],
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
                        _selectedCity = city;
                        _citiesPerDay[_currentDayIndex].add(city);
                        _cityController.clear();
                        _isAddingCity = false;
                      });
                    }
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
