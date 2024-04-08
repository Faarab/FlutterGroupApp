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
    "id": "123456",
    "name": "Sample Trip",
    "startDate": "2024-03-25T00:00:00.000Z",
    "endDate": "2024-04-02T00:00:00.000Z",
    "cityOfDeparture": "City A",
    "cityOfArrival": "City B",
    "days": [
      {
        "date": "2024-03-25T00:00:00.000Z",
        "activities": [
          {
            "name": "Activity 1",
            "startTime": "2024-03-25T08:00:00.000Z",
            "openingTime": "2024-03-25T07:00:00.000Z",
            "closingTime": "2024-03-25T17:00:00.000Z",
            "location": "Location 1",
            "price": 10.5
          },
          {
            "name": "Activity 2",
            "startTime": "2024-03-25T10:00:00.000Z",
            "openingTime": "2024-03-25T09:00:00.000Z",
            "closingTime": "2024-03-25T18:00:00.000Z",
            "location": "Location 2",
            "price": 15.75
          }
        ]
      },
      {
        "date": "2024-03-26T00:00:00.000Z",
        "activities": [
          {
            "name": "Activity 3",
            "startTime": "2024-03-26T09:00:00.000Z",
            "openingTime": "2024-03-26T08:00:00.000Z",
            "closingTime": "2024-03-26T16:00:00.000Z",
            "location": "Location 3",
            "price": 20.0
          }
        ]
      }
    ]
  }
""";