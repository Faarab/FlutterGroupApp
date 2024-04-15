
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/ActivityDTO.dart';
import 'package:triptaptoe_app/models/CityDTO.dart';
import 'package:triptaptoe_app/services/city_service.dart';

class SuggestedActivities extends StatefulWidget {
   const SuggestedActivities({super.key, required this.onActivityTapped, required this.selectedCity});
    

  final Function(ActivityDTO) onActivityTapped;
  final CityDTO? selectedCity;

  @override
  State<SuggestedActivities> createState() => _SuggestedActivitiesState();
}

class _SuggestedActivitiesState extends State<SuggestedActivities> {
  late List<String> categories;
  late Map<String, bool> filters;
  late List<ActivityDTO> activities;


  @override
  void initState() {
    super.initState();
    print("${widget.selectedCity?.name} selected city");
    
    categories = CityService().getCategories().toList();
    filters = { for (var category in categories) category: false };

    activities = _getAllActivities();
  }

List<ActivityDTO> _getAllActivities() {
  List<ActivityDTO> allActivities = [];
  final List<CityDTO> cities = CityService().getCities().toList();
  
  if (widget.selectedCity != null) {
    final selectedCityName = widget.selectedCity!.name;
    for (var city in cities) {
      if (city.name == selectedCityName) {
        allActivities.addAll(city.activities!);
        break; 
      }
    }
  } else {
    for (var city in cities) {
      allActivities.addAll(city.activities!);
    }
  }
  
  return allActivities;
}


  @override
  Widget build(BuildContext context) {
    final filteredActivities = activities.where((activity) {
      if (filters.values.any((selected) => selected)) {
        return filters.entries.any((filter) => filter.value && activity.category == filter.key);
      } else {
        return true;
      }
    }).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Suggested activities",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: filters.entries
                  .map(
                    (filter) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: FilterChip(
                        backgroundColor: Colors.transparent,
                        label: Text(filter.key),
                        selected: filter.value,
                        onSelected: (selected) {
                          setState(() {
                            filters[filter.key] = selected;
                          });
                        },
                        selectedColor: Colors.purple,
                        labelStyle: TextStyle(
                          color: filter.value ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 380,
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(
                filteredActivities.length,
                (index) {
                  final activity = filteredActivities[index];
                  return InkWell(
                    onTap: () {
                      widget.onActivityTapped(activity);
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.asset(
                              "assets/images/${activity.image}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              activity.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
