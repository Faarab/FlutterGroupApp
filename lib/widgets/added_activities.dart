import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/ActivityDTO.dart';
import 'package:triptaptoe_app/models/CityDTO.dart';
import 'package:triptaptoe_app/screens/add_activity_modal_screen.dart';
import 'package:triptaptoe_app/widgets/dialog_remove_city.dart';

class AddedActivities extends StatefulWidget {
  const AddedActivities({super.key, required this.citiesPerDay, required this.currentDayIndex, required this.onActivityAdded, this.selectedCity, required this.currentTripId, this.showDeleteBtn});

  final List<List<CityDTO>> citiesPerDay;
  final int currentDayIndex;
  final Function(ActivityDTO, CityDTO?) onActivityAdded;
  final CityDTO? selectedCity;
  final String currentTripId;
  final bool? showDeleteBtn;

  @override
  State<AddedActivities> createState() => _AddedActivitiesState();
}


class _AddedActivitiesState extends State<AddedActivities> {
  @override
  Widget build(BuildContext context) {
    final currentCities = widget.citiesPerDay[widget.currentDayIndex];
    if (currentCities.isEmpty) {
      return Container();
    }

    return ListView.separated(
      shrinkWrap: true,
      itemCount: currentCities.length,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 10),
      itemBuilder: (BuildContext context, int index) {
        final city = currentCities[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  currentCities[index].name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(width: 24),
                if(widget.showDeleteBtn!)
                IconButton(
  icon: const Icon(Icons.delete,
      color: Color.fromRGBO(53, 16, 79, 1)),
  onPressed: () {
    showDialog(context: context, builder: (BuildContext context) {
      return DialogRemoveCity(
        onCityRemoved: (name) {
          setState(() {
            widget.citiesPerDay[widget.currentDayIndex].removeAt(index);
          });
        },
        currentCityName: currentCities[index].name,
        currentTripId: widget.currentTripId,
        currentDayInd: widget.currentDayIndex,
        
      );
    });
  },
),

              ],
            ),
            Container(
              
              child: ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: city.activities?.length ?? 0, // Usa la lunghezza delle attività
  itemBuilder: (BuildContext context, int activityIndex) {
    final activity = city.activities?[activityIndex];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              activity?.name ?? 'no activity',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              activity != null
                  ? '${activity.startTime.hour}:${activity.startTime.minute}'
                  : '',
            )
          ],
        ),
      ),
    );
  },
),

            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text("Add an activity"),
                    onPressed: () {
                      
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (bmscontext) => AddActivityModal(
                          onActivityAdded:  (activity,selectedCity) {
                            widget.onActivityAdded(activity, selectedCity);
                          },
                          
                          selectedCity: city,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}