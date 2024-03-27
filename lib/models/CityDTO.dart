
import 'package:triptaptoe_app/models/ActivityDTO.dart';

class CityDTO {
  CityDTO({
    required this.name,
    this.activities
  });

  final String name;
  final List<ActivityDTO>? activities;

  factory CityDTO.fromJson(Map<String, dynamic> json) {

    late List<ActivityDTO> activities;
    if (json['activities'] != null) {
      activities = List<ActivityDTO>.from(json['activities'].map((day) => ActivityDTO.fromJson(day)));
    }

    return CityDTO(
      name: json['name'],
      activities: activities,
    );
  }
}