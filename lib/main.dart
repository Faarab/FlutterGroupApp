import 'dart:convert';
import 'dart:ffi';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/screens/Exchange_screen.dart';
import 'package:triptaptoe_app/widgets/app_bar_with_back_arrow.dart';
import 'package:triptaptoe_app/widgets/home_screen_bottom_navigation_bar.dart';

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

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  runApp( 
    MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(241,241,241,1),
          appBar: AppBarWithBackArrow(screen: Exchange_screen()),
          body: Exchange_screen(),
          bottomNavigationBar: HomeScreenBottomNavigationBar(),
          ),
      ),
    )
  );
}

