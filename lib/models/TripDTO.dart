import 'package:triptaptoe_app/models/DayDTO.dart';

class TripDTO {
  TripDTO({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.cityOfDeparture,
    required this.cityOfArrival,
    this.days,
  });

  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String cityOfDeparture;
  final String cityOfArrival;
  final List<DayDTO>? days;

  factory TripDTO.fromJson(Map<String, dynamic> json) {
    late List<DayDTO>? days;
    final numOfDays = json['days'].length;
    if (numOfDays != 0) {
      days = List<DayDTO>.from(json['days'].map((day) => DayDTO.fromJson(day)));
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
      };

  @override
  String toString() {
    return '{id: $id, name: $name, startDate: $startDate, endDate: $endDate, cityOfDeparture: $cityOfDeparture, cityOfArrival: $cityOfArrival, days: $days}';
  }
  
  String formatStartDate() {
    return "${startDate.day.toString().padLeft(2,'0')}/${startDate.month.toString().padLeft(2,'0')}/${startDate.year}";
  }

  String formatEndtDate() {
    return "${endDate.day.toString().padLeft(2,'0')}/${endDate.month.toString().padLeft(2,'0')}/${endDate.year}";
  }

}