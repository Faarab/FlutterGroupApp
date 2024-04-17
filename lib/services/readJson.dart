import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';

Future<List<TripDTO>> readJson() async {
  final myDirectory = await getApplicationDocumentsDirectory();
  final myPath = myDirectory.path;
  final myFile = File('$myPath/trips.json');
  //myFile.writeAsString("");

  if (!await myFile.exists()) {
    await myFile.writeAsString("""
{
  "trips": [
    {
      "id": "1",
      "name": "Viaggio di esempio",
      "startDate": "2024-04-13T00:00:00.000Z",
      "endDate": "2024-04-20T00:00:00.000Z",
      "cityOfDeparture": "Città di partenza",
      "cityOfArrival": "Città di arrivo",
      "days": [
        {
          "date": "2024-04-13T00:00:00.000Z",
          "cities": [
            {
              "name": "Città 1",
              "activities": [
                {
                  "name": "Attività 1",
                  "startTime": "2024-04-13T08:00:00.000Z",
                  "openingTime": null,
                  "closingTime": null,
                  "location": "C/ de Mallorca, 401, L'Eixample, 08013 Barcelona, Spagna",
                  "price": 10.0,
                  "image": "url_immagine_1",
                  "category": "Categoria 1"
                },
                {
                  "name": "Attività 2",
                  "startTime": "2024-04-13T10:00:00.000Z",
                  "openingTime": null,
                  "closingTime": null,
                  "location": "Luogo 2",
                  "price": null,
                  "image": null,
                  "category": null
                },
                {
                  "name": "Attività 3",
                  "startTime": "2024-04-13T12:00:00.000Z",
                  "openingTime": "2024-04-13T10:00:00.000Z",
                  "closingTime": "2024-04-13T18:00:00.000Z",
                  "location": "Luogo 3",
                  "price": 20.0,
                  "image": "url_immagine_3",
                  "category": "Categoria 2"
                }
              ]
            },
            {
              "name": "Città 4",
              "activities": [
                {
                  "name": "Attività 4",
                  "startTime": "2024-04-13T14:00:00.000Z",
                  "openingTime": "2024-04-13T12:00:00.000Z",
                  "closingTime": "2024-04-13T20:00:00.000Z",
                  "location": "Luogo 4",
                  "price": 15.0,
                  "image": "url_immagine_4",
                  "category": "Categoria 3"
                }
              ]
            }
          ]
        },
        {
          "date": "2024-04-14T00:00:00.000Z",
          "cities": [
            {
              "name": "Città 5",
              "activities": [
                {
                  "name": "Attività 5",
                  "startTime": "2024-04-14T09:00:00.000Z",
                  "openingTime": null,
                  "closingTime": null,
                  "location": "Luogo 5",
                  "price": null,
                  "image": null,
                  "category": null
                },
                {
                  "name": "Attività 6",
                  "startTime": "2024-04-14T11:00:00.000Z",
                  "openingTime": "2024-04-14T10:00:00.000Z",
                  "closingTime": "2024-04-14T17:00:00.000Z",
                  "location": "Luogo 6",
                  "price": 25.0,
                  "image": "url_immagine_6",
                  "category": "Categoria 4"
                }
              ]
            },
            {
              "name": "Città 7",
              "activities": null
            }
          ]
        },
        {
          "date": "2024-04-15T00:00:00.000Z",
          "cities": []
        }
      ]
    }
  ]
}

""");
  }
  final contents = await myFile.readAsString();
  if (contents != "") {
    final Map<String, dynamic> contentsJSON = jsonDecode(contents);
    print("readJson contents  " + contentsJSON.toString());

    List<dynamic> dynamicTripsList = contentsJSON['trips'];
    print("dynamictripslist" + dynamicTripsList.toString());
    final List<TripDTO> tripsList = dynamicTripsList.map(
      (e) {
        return TripDTO.fromJson(e);
      },
    ).toList();
    print("tripsList" + tripsList.toString());
    return tripsList;
    // setState(() {
    //   tripArray = tripsList;
    // });
  } else {
    print("File is empty");
    return <TripDTO>[];
  }
}
