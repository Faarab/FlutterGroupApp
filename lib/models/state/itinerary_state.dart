import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:triptaptoe_app/models/ActivityDTO.dart';
import 'package:triptaptoe_app/models/CityDTO.dart';
import 'package:triptaptoe_app/models/DayDTO.dart';

class ItineraryState extends ChangeNotifier {
  final List<DayDTO> _days = List.empty(growable: true);


  UnmodifiableListView<DayDTO> get cityView => UnmodifiableListView(_days);

  addDayAndCity(CityDTO city, DateTime date) {
    final d = _days.firstWhere((element) => element.date == date, orElse: () {
      return DayDTO(date: date, cities: List.empty(growable: true));
    });
    
    d.cities!.add(city);
    _days.add(d);

    notifyListeners();
  }

  addActivities(String name,  DateTime date, ActivityDTO act){
    final d = _days.firstWhere((element) => element.date == date);
    final c = d.cities!.firstWhere((element) => element.name == name);

    c.activities ??= List.empty(growable: true);
    c.activities!.add(act);

    notifyListeners();
  }
  
  reset(){
    _days.clear();

    notifyListeners();
  }
}