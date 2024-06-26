import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import 'package:triptaptoe_app/models/ActivityDTO.dart';
import 'package:triptaptoe_app/models/CityDTO.dart';
import 'package:triptaptoe_app/models/DayDTO.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/models/state/itinerary_state.dart';
import 'package:triptaptoe_app/screens/edit_itinerary_screen.dart';
import 'package:triptaptoe_app/screens/home_screen.dart';
import 'package:triptaptoe_app/services/modifyCompleteTripFromJson.dart';
import 'package:triptaptoe_app/widgets/activities_adder.dart';
import 'package:triptaptoe_app/widgets/change_day_itinerary.dart';
import 'package:intl/intl.dart';
import 'package:triptaptoe_app/widgets/city_card.dart';

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

final List<Map<String, dynamic>> citiesList = [
  {"name": "Barcelona", "country": "Spain"},
  {"name": "Malaga", "country": "Spain"},
  {"name": "Valencia", "country": "Spain"},
  {"name": "Madrid", "country": "Spain"},
  {"name": "Granada", "country": "Spain"},
  {"name": "London", "country": "United Kingdom"},
  {"name": "Birmingham", "country": "United Kingdom"},
  {"name": "Glasgow", "country": "United Kingdom"},
  {"name": "Liverpool", "country": "United Kingdom"},
  {"name": "Edinburgh", "country": "United Kingdom"}
];

class EditItineraryBody extends StatefulWidget {
  const EditItineraryBody(
      {super.key, required this.widget, required this.trip});

  final EditItineraryScreen widget;
  final TripDTO trip;

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
  late List<List<CityDTO>> _citiesPerDay = [];
  CityDTO? selectedCity;
  late String _id;
  late String _name;
  late String _cityOfDeparture;
  late String _cityOfArrival;
  late DateTime _startDate;
  late DateTime _endDate;
  late List<DayDTO> _days = [];

  void _onActivityAdded(ActivityDTO activity, CityDTO? selectedCity) {
    setState(() {
      if (selectedCity != null) {
        int cityIndex = _citiesPerDay[_currentDayIndex].indexOf(selectedCity);
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
                print(activity);
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
    hardcodedcitieslist = citiesList
        .map((city) => CityDTO(name: city["name"]!, country: city["country"]!))
        .toList();

    _currentDayIndex = 0;
    _canGoBackward = false;
    if (widget.widget.trip.days!.length > 1) {
      _canGoForward = true;
    } else {
      _canGoForward = false;
    }
    _citiesPerDay = List.generate(widget.widget.trip.days!.length, (_) => []);
    _id = widget.trip.id;
    _name = widget.widget.trip.name;
    _cityOfDeparture = widget.widget.trip.cityOfDeparture;
    _cityOfArrival = widget.trip.cityOfArrival;
    _startDate = widget.trip.startDate;
    _endDate = widget.trip.endDate;
    _days = maptoDayDto(widget.widget.trip.days!, _citiesPerDay);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 29, right: 26),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Edit Itinerary",
                  style: TextStyle(
                    color: Color.fromRGBO(45, 45, 45, 1),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                     fontFamily: 'Poppins'
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => const Color.fromRGBO(53, 16, 79, 1)),
                        overlayColor: MaterialStateColor.resolveWith((states) =>
                            const Color.fromRGBO(199, 156, 230, 0.094)),
                        shape: MaterialStateProperty.all(CircleBorder()),
                        minimumSize: MaterialStateProperty.all(Size(50, 50))),
                    onPressed: () async {
                      final data =
                          maptoDayDto(widget.widget.trip.days!, _citiesPerDay);

                      final isModified = await modifyCompleteTripFromJson(
                        widget.trip.id,
                        _name,
                        _startDate,
                        _endDate,
                        _cityOfDeparture,
                        _cityOfArrival,
                        _days,
                      );

                      if (isModified) {
                        setState(() {
                          _days = data;
                          _citiesPerDay = List.generate(
                              _days.length, (index) => _days[index].cities!);
                        });
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    child: const Icon(
                      Icons.save,
                      color: Colors.white,
                    )),
              ],
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
              ActivitiesAdder(
                citiesPerDay: _citiesPerDay,
                currentDayIndex: _currentDayIndex,
                onActivityAdded: (act, selectedCity) {
                  _onActivityAdded(act, selectedCity);
                },
                currentTripId: _id,
                showDeleteBtn: false,
              ),
            const SizedBox(height: 10),
            CityCard(
                hardcodedcitieslist: hardcodedcitieslist,
                citiesPerDay: _citiesPerDay,
                currentDayIndex: _currentDayIndex,
                isAddingCity: _isAddingCity,
                onCitySelected: (city) {
                  setState(() {
                    selectedCity = city;
                    _citiesPerDay[_currentDayIndex].add(city);
                    _cityController.clear();
                    _isAddingCity = false;


                  });
                },),
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
}
