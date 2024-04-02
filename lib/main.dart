import 'dart:convert';
import 'dart:ffi';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/services/Api.dart';

import 'screens/itinerary_screen.dart';
import 'widgets/app_bar_with_back_arrow.dart';
import 'widgets/body_itenerary.dart';
import 'widgets/bottom_navigation_bar_trip.dart';

const tripjson = """
{
  "id": "123456",
  "name": "Viaggio di esempio",
  "startDate": "2024-04-01T08:00:00Z",
  "endDate": "2024-04-09T20:00:00Z",
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
            },
            {
              "name": "Attività 3",
              "startTime": "2024-04-01T14:00:00Z",
              "openingTime": "2024-04-01T10:00:00Z",
              "closingTime": "2024-04-01T18:00:00Z",
              "location": "Luogo 3",
              "price": 15.0
            },
            {
              "name": "Attività 4",
              "startTime": "2024-04-01T13:00:00Z",
              "openingTime": "2024-04-01T09:00:00Z",
              "closingTime": "2024-04-01T17:00:00Z",
              "location": "Luogo 4",
              "price": 25.0
            },
            {
              "name": "Attività 5",
              "startTime": "2024-04-01T12:00:00Z",
              "openingTime": "2024-04-01T09:00:00Z",
              "closingTime": "2024-04-01T18:00:00Z",
              "location": "Luogo 5",
              "price": 30.0
            }
          ]
        },
        {
          "name": "Madrid",
          "activities": [
            {
              "name": "Attività 6",
              "startTime": "2024-04-01T16:00:00Z",
              "openingTime": "2024-04-01T10:00:00Z",
              "closingTime": "2024-04-01T18:00:00Z",
              "location": "Luogo 6",
              "price": 35.0
            },
            {
              "name": "Attività 7",
              "startTime": "2024-04-01T14:00:00Z",
              "openingTime": "2024-04-01T10:00:00Z",
              "closingTime": "2024-04-01T18:00:00Z",
              "location": "Luogo 7",
              "price": 40.0
            },
            {
              "name": "Attività 8",
              "startTime": "2024-04-01T13:00:00Z",
              "openingTime": "2024-04-01T10:00:00Z",
              "closingTime": "2024-04-01T18:00:00Z",
              "location": "Luogo 8",
              "price": 45.0
            },
            {
              "name": "Attività 9",
              "startTime": "2024-04-01T12:00:00Z",
              "openingTime": "2024-04-01T10:00:00Z",
              "closingTime": "2024-04-01T18:00:00Z",
              "location": "Luogo 9",
              "price": 50.0
            },
            {
              "name": "Attività 10",
              "startTime": "2024-04-01T11:00:00Z",
              "openingTime": "2024-04-01T10:00:00Z",
              "closingTime": "2024-04-01T18:00:00Z",
              "location": "Luogo 10",
              "price": 55.0
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
              "name": "Attività 11",
              "startTime": "2024-04-02T14:00:00Z",
              "openingTime": "2024-04-02T09:00:00Z",
              "closingTime": "2024-04-02T18:00:00Z",
              "location": "Luogo 11",
              "price": 60.0
            },
            {
              "name": "Attività 12",
              "startTime": "2024-04-02T12:00:00Z",
              "openingTime": "2024-04-02T09:00:00Z",
              "closingTime": "2024-04-02T18:00:00Z",
              "location": "Luogo 12",
              "price": 65.0
            },
            {
              "name": "Attività 13",
              "startTime": "2024-04-02T11:00:00Z",
              "openingTime": "2024-04-02T09:00:00Z",
              "closingTime": "2024-04-02T18:00:00Z",
              "location": "Luogo 13",
              "price": 70.0
            },
            {
              "name": "Attività 14",
              "startTime": "2024-04-02T10:00:00Z",
              "openingTime": "2024-04-02T09:00:00Z",
              "closingTime": "2024-04-02T18:00:00Z",
              "location": "Luogo 14",
              "price": 75.0
            },
            {
              "name": "Attività 15",
              "startTime": "2024-04-02T09:00:00Z",
              "openingTime": "2024-04-02T09:00:00Z",
              "closingTime": "2024-04-02T18:00:00Z",
              "location": "Luogo 15",
              "price": 80.0
            }
          ]
        }
      ]
    },
    {
      "date": "2024-04-03T00:00:00Z",
      "cities": [
        {
          "name": "Città 3",
          "activities": [
            {
              "name": "Attività 16",
              "startTime": "2024-04-03T15:00:00Z",
              "openingTime": "2024-04-03T09:00:00Z",
              "closingTime": "2024-04-03T18:00:00Z",
              "location": "Luogo 16",
              "price": 85.0
            },
            {
              "name": "Attività 17",
              "startTime": "2024-04-03T13:00:00Z",
              "openingTime": "2024-04-03T09:00:00Z",
              "closingTime": "2024-04-03T18:00:00Z",
              "location": "Luogo 17",
              "price": 90.0
            },
            {
              "name": "Attività 18",
              "startTime": "2024-04-03T11:00:00Z",
              "openingTime": "2024-04-03T09:00:00Z",
              "closingTime": "2024-04-03T18:00:00Z",
              "location": "Luogo 18",
              "price": 95.0
            },
            {
              "name": "Attività 19",
              "startTime": "2024-04-03T10:00:00Z",
              "openingTime": "2024-04-03T09:00:00Z",
              "closingTime": "2024-04-03T18:00:00Z",
              "location": "Luogo 19",
              "price": 100.0
            },
            {
              "name": "Attività 20",
              "startTime": "2024-04-03T09:00:00Z",
              "openingTime": "2024-04-03T09:00:00Z",
              "closingTime": "2024-04-03T18:00:00Z",
              "location": "Luogo 20",
              "price": 105.0
            }
          ]
        }
      ]
    },
    {
      "date": "2024-04-04T00:00:00Z",
      "cities": [
        {
          "name": "Città 4",
          "activities": [
            {
              "name": "Attività 21",
              "startTime": "2024-04-04T14:00:00Z",
              "openingTime": "2024-04-04T09:00:00Z",
              "closingTime": "2024-04-04T18:00:00Z",
              "location": "Luogo 21",
              "price": 110.0
            },
            {
              "name": "Attività 22",
              "startTime": "2024-04-04T12:00:00Z",
              "openingTime": "2024-04-04T09:00:00Z",
              "closingTime": "2024-04-04T18:00:00Z",
              "location": "Luogo 22",
              "price": 115.0
            },
            {
              "name": "Attività 23",
              "startTime": "2024-04-04T11:00:00Z",
              "openingTime": "2024-04-04T09:00:00Z",
              "closingTime": "2024-04-04T18:00:00Z",
              "location": "Luogo 23",
              "price": 120.0
            },
            {
              "name": "Attività 24",
              "startTime": "2024-04-04T10:00:00Z",
              "openingTime": "2024-04-04T09:00:00Z",
              "closingTime": "2024-04-04T18:00:00Z",
              "location": "Luogo 24",
              "price": 125.0
            },
            {
              "name": "Attività 25",
              "startTime": "2024-04-04T09:00:00Z",
              "openingTime": "2024-04-04T09:00:00Z",
              "closingTime": "2024-04-04T18:00:00Z",
              "location": "Luogo 25",
              "price": 130.0
            }
          ]
        }
      ]
    }
  ]
}
""";

final tripDiEsempio = TripDTO.fromJson(jsonDecode(tripjson));

void main() async {
  
  runApp( 
    MaterialApp(
      home: SafeArea(
        child: ItineraryScreen(trip: tripDiEsempio,),
      ),
    )
  );
}


