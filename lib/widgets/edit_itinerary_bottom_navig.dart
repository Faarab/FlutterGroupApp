import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import 'package:triptaptoe_app/models/ActivityDTO.dart';
import 'package:triptaptoe_app/models/CityDTO.dart';
import 'package:triptaptoe_app/models/DayDTO.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/models/state/itinerary_state.dart';
import 'package:triptaptoe_app/screens/edit_itinerary_screen.dart';
import 'package:triptaptoe_app/screens/edit_trip_screen.dart';
import 'package:triptaptoe_app/services/modifyCompleteTripFromJson.dart';
import 'package:triptaptoe_app/widgets/added_cities.dart';
import 'package:triptaptoe_app/widgets/change_day_itinerary.dart';
import '../screens/add_activity_modal_screen.dart';
import 'package:intl/intl.dart';

List<DayDTO> maptoDayDto(List<DayDTO> days, List<List<CityDTO>> citiesPerDay) {
  int i = 0;
  final m = citiesPerDay.map((e) {
    final d = days[i];
    final dd = DayDTO(date: d.date, cities: citiesPerDay[i]);
    i++;
    return dd;
  });
  return m.toList();
}


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

class EditItineraryBottomNavig extends StatefulWidget {
  const EditItineraryBottomNavig({super.key, required this.widget, required this.trip});

  final EditTripScreen widget;
  final TripDTO trip;
 

  @override
  State<EditItineraryBottomNavig> createState() => _EditItineraryBottomNavigState();
}

//     final days = context.watch<ItineraryState>().cityView;
//     final cities = days.firstWhere((element) => element.date == widget.widget.trip.days![_currentDayIndex]).cities;
class _EditItineraryBottomNavigState extends State<EditItineraryBottomNavig> {
  final TextEditingController _cityController = TextEditingController();
  bool _isAddingCity = false;
  late List<CityDTO> hardcodedcitieslist;
  List<ActivityDTO> activities = [];
  late int _currentDayIndex;
  late bool _canGoBackward;
  late bool _canGoForward;
  final ScrollController _scrollController = ScrollController();
  late List<List<CityDTO>> _citiesPerDay = [];
  CityDTO? _selectedCity;
late String _name;
  late String _cityOfDeparture;
  late String _cityOfArrival;
  late DateTime _startDate;
  late DateTime _endDate;
  late List<DayDTO> _days = [];
  late TripDTO _updatedTrip;


  void _onActivityAdded(ActivityDTO activity) {
    setState(() {
      if (_selectedCity != null) {
        int cityIndex = _citiesPerDay[_currentDayIndex].indexOf(_selectedCity!);
        if (cityIndex != -1) {
          if (_citiesPerDay[_currentDayIndex][cityIndex].activities != null) {
            int insertIndex = 0;
            for (int i = 0;
                i <
                    _citiesPerDay[_currentDayIndex][cityIndex]
                        .activities!
                        .length;
                i++) {
              if (activity.startTime.isBefore(_citiesPerDay[_currentDayIndex]
                      [cityIndex]
                  .activities![i]
                  .startTime)) {
                insertIndex = i;
                break;
              } else {
                insertIndex = i + 1;
              }
            }
            _citiesPerDay[_currentDayIndex][cityIndex]
                .activities!
                .insert(insertIndex, activity);
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
    hardcodedcitieslist = citiesStartingWithMa
        .map((city) => CityDTO(name: city["name"]!, country: city["country"]!))
        .toList();

    _currentDayIndex = 0;
    _canGoBackward = false;
    if (widget.widget.trip.days!.length > 1) {
      _canGoForward = true;
    } else {
      _canGoForward = false;
    }
     _citiesPerDay = widget.trip.days!.map((day) => day.cities ?? []).toList();
   
    _name = widget.widget.trip.name;
    _cityOfDeparture = widget.widget.trip.cityOfDeparture;
    _cityOfArrival = widget.trip.cityOfArrival;
    _startDate = widget.trip.startDate;
    _endDate = widget.trip.endDate;
    _days = maptoDayDto(widget.widget.trip.days!, _citiesPerDay);
    _updatedTrip = widget.widget.trip;
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
           
            ElevatedButton(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith((states) => Color.fromRGBO(53, 16, 79, 1)),
    overlayColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(199, 156, 230, 0.094)), 
    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
  ),
  onPressed: () async {
    final data = maptoDayDto(widget.widget.trip.days!, _citiesPerDay);
    print(data);
    print(_days);
    print("citiesperday $_citiesPerDay");

    try {
      final isModified = await modifyCompleteTripFromJson(
        widget.trip.id,
        _name,
        _startDate,
        _endDate,
        _cityOfDeparture,
        _cityOfArrival,
        _days,
      );
      print("Io soy il trip modificato + $isModified");

      if (isModified) {
        setState(() {
          _days = data;
          _citiesPerDay = List.generate(_days.length, (index) => _days[index].cities!);
        });
      }

      Navigator.pop(context);
    } catch (e) {
      print("Errore nel salvataggio del trip: $e");
    }
  },
  child: Text(
    "Save",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
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
            if (_isAddingCity || _citiesPerDay[_currentDayIndex].isNotEmpty)
             AddedCities(citiesPerDay: _citiesPerDay, currentDayIndex: _currentDayIndex, onActivityAdded:(act) {
                           _onActivityAdded(act);
                          },),
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
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 50)),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        alignment: Alignment.centerLeft),
                    label: const Text("Add a city",
                        style: TextStyle(color: Colors.black)),
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
                        return city.name
                            .toLowerCase()
                            .startsWith(textEditingValue.text.toLowerCase());
                      });
                    }
                  }, fieldViewBuilder: (fbContext, textEditingController,
                          focusNode, onFieldSubmitted) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        hintText: 'Enter a city',
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      onSubmitted: (value) {
                        final selectedCity = hardcodedcitieslist
                            .firstWhereOrNull((city) => city.name == value);

                        if (selectedCity != null) {
                          setState(() {
                            _citiesPerDay[_currentDayIndex].add(selectedCity);
                            textEditingController.clear();
                            _isAddingCity = false;
                          });
                        }
                      },
                    );
                  }, optionsViewBuilder: (optcontext, onSelected, cities) {
                    return Material(
                      color: Colors.transparent,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        itemCount: cities.length,
                        itemBuilder: (BuildContext context, int index) {
                          final city = cities.elementAt(index);
                          return ListTile(
                            leading: const Icon(Icons.location_on),
                            title: Text(
                              city.name,
                            ),
                            subtitle: Text(city.country ?? 'N/A'),
                            onTap: () {
                              onSelected(city);
                            },
                          );
                        },
                      ),
                    );
                  }, onSelected: (CityDTO city) {
                    setState(() {
                      _selectedCity = city;
                      _citiesPerDay[_currentDayIndex].add(city);
                      _cityController.clear();
                      _isAddingCity = false;
                    });
                    
                      context.read<ItineraryState>().addDayAndCity(city,
                          widget.widget.trip.days![_currentDayIndex].date);
                  }),
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
