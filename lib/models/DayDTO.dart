
import 'package:triptaptoe_app/models/ActivityDTO.dart';

class DayDTO {
  
  DayDTO({
    required this.date,
    this.activities,
  });

  final DateTime date;
  final List<ActivityDTO>? activities;

  Map<String, dynamic> toJson() => {
    'date': date,
    'activities': activities
  };

  @override
  String toString() {
    return '{date: $date, activities: $activities}';
  }

  factory DayDTO.fromJson(Map<String, dynamic> json) {

    late List<ActivityDTO> activities;
    if (json['activities'] != null) {
      activities = List<ActivityDTO>.from(json['activities'].map((day) => ActivityDTO.fromJson(day)));
    }

    return DayDTO(
      date: DateTime.parse(json['date']),
      activities: activities,
    );
  }
}