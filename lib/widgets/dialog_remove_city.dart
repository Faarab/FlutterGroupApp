import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DialogRemoveCity extends StatelessWidget {


  DialogRemoveCity({
    required this.onCityRemoved,
     required this.currentCityName, required this.currentTripId, required this.currentDayInd,
  });

  final Function(String) onCityRemoved;
  final String currentCityName;
  final String currentTripId;
  final int currentDayInd;

Future<void> deleteCity(String _cityName) async {
  final myDirectory = await getApplicationDocumentsDirectory();
  final myPath = myDirectory.path;
  final myFile = File('$myPath/trips.json');


  final contents = await myFile.readAsString();
  print("contents $contents");

  if (contents.isNotEmpty) {
    final Map<String, dynamic> contentsJSON = jsonDecode(contents);
    final List<dynamic> tripsList = contentsJSON['trips'];
    print("trip list $tripsList");
    
    final tripIndex = tripsList.indexWhere((trip) => trip['id'] == currentTripId); 
    print("trip index $tripIndex");
    
   

      final List<dynamic> daysList = tripsList[tripIndex]['days'];
      print("days list $daysList"); 
      
      final currentDayIndex = currentDayInd;
      final citiesList = daysList[currentDayIndex]['cities'];
      print("cities list $citiesList");


      citiesList.removeWhere((city) => city['name'] == _cityName); 

      contentsJSON['trips'][tripIndex]['days'][currentDayIndex]['cities'] = citiesList;
      print("cities list updated $citiesList");

      await myFile.writeAsString(jsonEncode(contentsJSON));
    
  }
}


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content:  Text("Do you want to delete $currentCityName?"),
      actions: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(53, 16, 79, 1)),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                SizedBox(
                  width: 120,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(53, 16, 79, 1)),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    onPressed: () async {
                      await deleteCity(currentCityName); 
                      onCityRemoved(currentCityName);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Delete",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
