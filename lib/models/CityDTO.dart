import 'package:triptaptoe_app/models/ActivityDTO.dart';

class CityDTO {


  CityDTO({
    this.country,
    required this.name,
    List<ActivityDTO>? activities,
  }) : activities = activities ?? [];

    final String? country;
  final String name;
  List<ActivityDTO>? activities;

  factory CityDTO.fromJson(Map<String, dynamic> json) {
    List<ActivityDTO> activities = json['activities'] != null
        ? List<ActivityDTO>.from(
            json['activities'].map((day) => ActivityDTO.fromJson(day)))
        : [];

    return CityDTO(
      country: json['country'],
      name: json['name'],
      activities: activities,
    );
  }

  Map<String, dynamic> toJson() => {
        "country": country,
        "name": name,
        "activities": activities?.map((activity) => activity.toJson()).toList(),
      };
}
