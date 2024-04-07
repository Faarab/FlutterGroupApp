
import 'package:triptaptoe_app/models/CityDTO.dart';

class DayDTO {
  
  DayDTO({
    required this.date,
    this.cities,
  });

  final DateTime date;
  final List<CityDTO>? cities;

  Map<String, dynamic> toJson() => {
    'date': date,
    'activities': cities
  };

  @override
  String toString() {
    return '{date: $date, cities: $cities}';
  }

  factory DayDTO.fromJson(Map<String, dynamic> json) {
    return DayDTO(
      date: DateTime.parse(json['date']),
      cities: json['cities'] != null
          ? (json['cities'] as List)
              .map((i) => CityDTO.fromJson(i))
              .toList()
          : null,
    );
  }

  String formatDate() {
      return "${date.day.toString().padLeft(2,'0')}/${date.month.toString().padLeft(2,'0')}/${date.year}";
    }
}