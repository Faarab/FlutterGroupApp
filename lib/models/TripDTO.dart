import 'dart:convert';

import 'package:triptaptoe_app/models/DayDTO.dart';

class TripDTO {
  TripDTO({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.cityOfDeparture,
    required this.cityOfArrival,
    required this.days,
  });

  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String cityOfDeparture;
  final String cityOfArrival;
  final List<DayDTO>? days;

  TripDTO copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    String? cityOfDeparture,
    String? cityOfArrival,
    List<DayDTO>? days,
  }) {
    return TripDTO(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      cityOfDeparture: cityOfDeparture ?? this.cityOfDeparture,
      cityOfArrival: cityOfArrival ?? this.cityOfArrival,
      days: days ?? this.days,
    );
  }
factory TripDTO.fromJson(Map<String, dynamic> json) {
  late List<DayDTO>? days;
  final dynamic numOfDays = json['days'];

  if (numOfDays != null && numOfDays is List) {
    final listOfDays = numOfDays as List;
    days = listOfDays.map((day) => DayDTO.fromJson(day)).toList();
  } else {
    days = <DayDTO>[];
  }
    return TripDTO(
      id: json["id"],
      name: json["name"],
      startDate: DateTime.parse(json["startDate"]),
      endDate: DateTime.parse(json["endDate"]),
      cityOfDeparture: json["cityOfDeparture"],
      cityOfArrival: json["cityOfArrival"],
      days: days,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "cityOfDeparture": cityOfDeparture,
    "cityOfArrival": cityOfArrival,
    "days": days?.map((day) => day.toJson()).toList(),
  };

  @override
  String toString() {
    return '{id: $id, name: $name, startDate: $startDate, endDate: $endDate, cityOfDeparture: $cityOfDeparture, cityOfArrival: $cityOfArrival, days: $days}';
  }

  String formatStartDate() {
    return "${startDate.day.toString().padLeft(2, '0')}/${startDate.month.toString().padLeft(2, '0')}/${startDate.year}";
  }

  String formatEndtDate() {
    return "${endDate.day.toString().padLeft(2, '0')}/${endDate.month.toString().padLeft(2, '0')}/${endDate.year}";
  }
}
