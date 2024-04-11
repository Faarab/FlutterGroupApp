import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:triptaptoe_app/models/DayDTO.dart';
import 'package:triptaptoe_app/services/getDaysList.dart';

Future<bool> modifyTripFromJson(String id, String name, DateTime startDate, DateTime endDate, String cityOfDeparture, String cityOfArrival) async {
  final myDirectory = await getApplicationDocumentsDirectory();
  final myPath = myDirectory.path;
  final myFile = File('$myPath/trips.json');
  final contents = await myFile.readAsString();
  if (contents != "") {
    try {
      final Map<String, dynamic> contentsJSON = jsonDecode(contents);
      List<dynamic> dynamicTripsList = contentsJSON['trips'];
      dynamicTripsList.firstWhere((element) => element['id'] == id);
      var tripToModify = dynamicTripsList.firstWhere((element) => element['id'] == id, orElse: () => null);
      
      if (tripToModify != null) {
        tripToModify['name'] = name;
        tripToModify['cityOfDeparture'] = cityOfDeparture;
        tripToModify['cityOfArrival'] = cityOfArrival;

        //se i giorni di inizio o fine viaggio sono diversi allora deve cambiare la lista di giorni del viaggio
        if (tripToModify['startDate'] != startDate.toIso8601String() 
            || tripToModify['endDate'] != endDate.toIso8601String()) {
          tripToModify['startDate'] = startDate.toIso8601String();
          tripToModify['endDate'] = endDate.toIso8601String();
          List<DayDTO> daysList = getDaysList(startDate, endDate);
          List<Map<String, dynamic>> daysJsonList = daysList.map((day) => day.toJson()).toList();
          tripToModify['days'] = daysJsonList;
        }

        contentsJSON['trips'] = dynamicTripsList;
        await myFile.writeAsString(jsonEncode(contentsJSON));

        return true;

      } else {
        return false;

      }
    } catch (e) {
      return false;

    }
  }
  return false;

}