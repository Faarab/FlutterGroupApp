import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/ActivityDTO.dart';
import 'package:triptaptoe_app/models/CityDTO.dart';
import 'package:triptaptoe_app/screens/add_activity_modal_screen.dart';
import 'package:triptaptoe_app/widgets/dialog_remove_city.dart';

class AddedCities extends StatefulWidget {
  const AddedCities({super.key, required this.citiesPerDay, required this.currentDayIndex, required this.onActivityAdded});

  final List<List<CityDTO>> citiesPerDay;
  final int currentDayIndex;
  final Function(ActivityDTO) onActivityAdded;

  @override
  State<AddedCities> createState() => _AddedCitiesState();
}

class _AddedCitiesState extends State<AddedCities> {
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
                IconButton(
  icon: const Icon(Icons.delete,
      color: Color.fromRGBO(53, 16, 79, 1)),
  onPressed: () {
    showDialog(context: context, builder: (BuildContext context) {
      return DialogRemoveCity(
        onCityRemoved: (index) {
          setState(() {
            widget.citiesPerDay[widget.currentDayIndex].removeAt(index);
          });
        },
        cityIndex: index,
      );
    });
  },
),

              ],
            ),
            Container(
              height: city.activities?.isNotEmpty ?? false ? null : 0,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: city.activities?.length,
                itemBuilder: (BuildContext context, int activityIndex) {
                  final activity = city.activities?[activityIndex];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            city.activities != null &&
                                    index < city.activities!.length
                                ? city.activities![index].name
                                : 'no city no party',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            city.activities != null &&
                                    activityIndex < city.activities!.length
                                ? '${city.activities![activityIndex].startTime.hour}:${city.activities![activityIndex].startTime.minute}'
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
                      print(city);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (bmscontext) => AddActivityModal(
                          onActivityAdded:  widget.onActivityAdded,
                          
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