import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/screens/itinerary_screen.dart';

const tripjson = """{
  "id": "123456",
  "name": "Viaggio di esempio",
  "startDate": "2024-04-01T08:00:00Z",
  "endDate": "2024-04-07T20:00:00Z",
  "cityOfDeparture": "Città di partenza",
  "cityOfArrival": "Città di arrivo",
  "days": [
    {
      "date": "2024-04-01T00:00:00Z",
      "cities": [
        {
          "name": "Barcellona",
          "activities": [
            {
              "name": "Sagrada Familia",
              "startTime": "2024-04-01T10:00:00Z",
              "openingTime": "2024-04-01T09:00:00Z",
              "closingTime": "2024-04-01T17:00:00Z",
              "location": "Calle de Mallorca, 401",
              "price": 10.0
            },
            {
              "name": "Attività 2",
              "startTime": "2024-04-01T15:00:00Z",
              "openingTime": "2024-04-01T09:00:00Z",
              "closingTime": "2024-04-01T17:00:00Z",
              "location": "Luogo 2",
              "price": 20.0
            }
          ]
        },
        {
          "name": "Madrid",
          "activities": [
            {
              "name": "Attività 3",
              "startTime": "2024-04-01T12:00:00Z",
              "openingTime": "2024-04-01T10:00:00Z",
              "closingTime": "2024-04-01T18:00:00Z",
              "location": "Luogo 3",
              "price": 15.0
            }
          ]
        }
      ]
    },
    {
      "date": "2024-04-02T00:00:00Z",
      "cities": [
        {
          "name": "Città 2",
          "activities": [
            {
              "name": "Attività 4",
              "startTime": "2024-04-02T11:00:00Z",
              "openingTime": "2024-04-02T09:00:00Z",
              "closingTime": "2024-04-02T18:00:00Z",
              "location": "Luogo 4",
              "price": 25.0
            }
          ]
        }
      ]
    }
  ]
}
""";

final tripDiEsempio = TripDTO.fromJson(jsonDecode(tripjson));

class Fake extends StatelessWidget {
  const Fake({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        height: 300,
        width: 300,
        child: Center(
          child: Column(
            children: [
                Text("Clicca qui per tornare alla schermata principale", style: TextStyle(color: Colors.white),),
                IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ItineraryScreen(trip: tripDiEsempio,)));
                },
              ),
            ]
          ),
        ),
      ),
    );
  }
}