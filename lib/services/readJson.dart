import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';

Future<List<TripDTO>> readJson() async {
  final myDirectory = await getApplicationDocumentsDirectory();
  final myPath = myDirectory.path;
  print(myPath);
  final myFile = File('$myPath/trips.json');
  //myFile.writeAsString("");
  final contents = await myFile.readAsString();
  if (contents != "") {
    final Map<String, dynamic> contentsJSON = jsonDecode(contents);
    print(contentsJSON);

    List<dynamic> dynamicTripsList = contentsJSON['trips'];
    print("dynamictripslist" + dynamicTripsList.toString());
    final List<TripDTO> tripsList = dynamicTripsList.map(
      (e) {
        return TripDTO.fromJson(e);
      },
    ).toList();
    print(tripsList);
    return tripsList;
    // setState(() {
    //   tripArray = tripsList;
    // });
  } else {
    print("File is empty");
    return <TripDTO>[];
  }
}
