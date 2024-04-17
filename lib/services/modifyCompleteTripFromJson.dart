import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:triptaptoe_app/models/DayDTO.dart';


Future<bool> modifyCompleteTripFromJson(String id, String name, DateTime startDate, DateTime endDate, String cityOfDeparture, String cityOfArrival, List<DayDTO> days) async {
  final myDirectory = await getApplicationDocumentsDirectory();
  final myPath = myDirectory.path;
  final myFile = File('$myPath/trips.json');
  final contents = await myFile.readAsString();


  if (contents != "") {
    try {
      final Map<String, dynamic> contentsJSON = jsonDecode(contents);
      List<dynamic> dynamicTripsList = contentsJSON['trips'];

      int index = dynamicTripsList.indexWhere((element) => element['id'] == id);
      
      if (index != -1) {
        var tripToModify = dynamicTripsList[index];
        
        tripToModify['name'] = name;
        tripToModify['startDate'] = startDate.toIso8601String();
        tripToModify['endDate'] = endDate.toIso8601String();
        tripToModify['cityOfDeparture'] = cityOfDeparture;
        tripToModify['cityOfArrival'] = cityOfArrival;

        List<Map<String, dynamic>> daysJsonList = days.map((day) => day.toJson()).toList();
        tripToModify['days'] = daysJsonList;

        contentsJSON['trips'] = dynamicTripsList;
        await myFile.writeAsString(jsonEncode(contentsJSON));

        return true;
      } else {
        print("non corresponding id $id"); 
        return false;
      }
    } catch (e) {
      print(e);
      
      return false;
    }
  } else {
    print("empty file"); 
    return false;
  }
}
