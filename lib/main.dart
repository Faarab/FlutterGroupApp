import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'dart:convert';

import 'screens/edit_itinerary_screen.dart';

final Map<String, dynamic> jsonData = jsonDecode(tripJson);
final TripDTO trip = TripDTO.fromJson(jsonData);



void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: EditItineraryScreen()
        )
      ));
}


    const String tripJson = """{
  "trips": [
    {
      "id": "1",
      "name": "Viaggio a Madrid e Barcellona",
      "startDate": "2024-05-01T00:00:00Z",
      "endDate": "2024-05-07T00:00:00Z",
      "cityOfDeparture": "Città di partenza",
      "cityOfArrival": "Città di arrivo",
      "days": [
        {
          "date": "2024-05-01T00:00:00Z",
          "activities": [
            {
              "name": "Visita al Museo del Prado",
              "startTime": "2024-05-01T09:00:00Z",
              "openingTime": "2024-05-01T09:00:00Z",
              "closingTime": "2024-05-01T20:00:00Z",
              "location": "Madrid",
              "price": 15.99
            },
            {
              "name": "Pranzo al ristorante El Botín",
              "startTime": "2024-05-01T13:00:00Z",
              "location": "Madrid",
              "price": 25.99
            }
          ]
        },
        {
          "date": "2024-05-02T00:00:00Z",
          "activities": [
            {
              "name": "Escursione al Parco Güell",
              "startTime": "2024-05-02T10:00:00Z",
              "openingTime": "2024-05-02T08:00:00Z",
              "closingTime": "2024-05-02T18:00:00Z",
              "location": "Barcellona",
              "price": 10.99
            },
            {
              "name": "Cena al ristorante Tickets",
              "startTime": "2024-05-02T19:30:00Z",
              "location": "Barcellona",
              "price": 35.99
            }
          ]
        },
        {
          "date": "2024-05-03T00:00:00Z",
          "activities": [
            {
              "name": "Tour guidato al Palazzo Reale di Madrid",
              "startTime": "2024-05-03T11:00:00Z",
              "openingTime": "2024-05-03T10:00:00Z",
              "closingTime": "2024-05-03T17:00:00Z",
              "location": "Madrid",
              "price": 20.99
            },
            {
              "name": "Spettacolo di flamenco al Tablao Villa Rosa",
              "startTime": "2024-05-03T20:00:00Z",
              "location": "Madrid",
              "price": 30.99
            }
          ]
        }
      ]
    }
  ]
}
""";