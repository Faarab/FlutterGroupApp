import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/screens/edit_trip_screen.dart';
import 'package:triptaptoe_app/screens/home_screen.dart';
import 'package:triptaptoe_app/screens/itinerary_screen.dart';
import 'package:path_provider/path_provider.dart';

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip, required this.index});

  final TripDTO trip;
  final int index;

  void deleteTrip(String _tripId) async {
    print("TRIPID " + _tripId);
    final myDirectory = await getApplicationDocumentsDirectory();
    final myPath = myDirectory.path;
    final myFile = File('$myPath/trips.json');
    final contents = await myFile.readAsString();
    print("CONTENTSCARD" + contents);

    final contentsJSON = jsonDecode(contents);
    print("CONTENTS JSON " + contentsJSON.toString());
    final List<dynamic> tripsList = contentsJSON['trips'];
    var updatedList = [...tripsList];
    updatedList.removeWhere((trip) => trip['id'] == _tripId);
    print("CONTENTS UPDATED LIST " + updatedList.toString());
    contentsJSON['trips'] = updatedList;

    print("CONTENTS JSON UPDATE " + contentsJSON.toString());
    await myFile.writeAsString(jsonEncode(contentsJSON));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //If the index is 0, the "Your trips" title is added to the home screen
        if (index == 0)
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              const Text("Your trips",
                  style: TextStyle(
                      color: Color.fromRGBO(45, 45, 45, 1),
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 16)
            ],
          ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ItineraryScreen(trip: trip)));
          },
          child: Card(
            color: const Color.fromRGBO(255, 255, 255, 1),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 4, top: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          trip.name,
                          style: const TextStyle(
                              color: Color.fromRGBO(45, 45, 45, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => Dialog(
                                    child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Are you sure you want to delete your trip?",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      45, 45, 45, 1),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            const Text(
                                                textAlign: TextAlign.center,
                                                softWrap: true,
                                                "This will permanently delete the trip and all information associated with it.",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        45, 45, 45, 1),
                                                    fontSize: 16)),
                                            const SizedBox(
                                              height: 32,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: OutlinedButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: Text("Cancel"),
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        side: const BorderSide(
                                                            color:
                                                                Color.fromRGBO(
                                                                    53,
                                                                    16,
                                                                    79,
                                                                    1),
                                                            width: 2),
                                                        foregroundColor:
                                                            const Color
                                                                .fromRGBO(
                                                                53, 16, 79, 1),
                                                      )),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        backgroundColor:
                                                            Color.fromRGBO(
                                                                53, 16, 79, 1),
                                                        foregroundColor:
                                                            Color.fromRGBO(255,
                                                                255, 255, 1),
                                                      ),
                                                      onPressed: () => {
                                                            deleteTrip(trip.id),
                                                            Navigator.of(
                                                                    context)
                                                                .popUntil((route) =>
                                                                    route
                                                                        .isFirst),
                                                            Navigator.pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            HomeScreen()))
                                                          },
                                                      child:
                                                          Text("Yes, delete")),
                                                )
                                              ],
                                            )
                                          ],
                                        ))));
                          },
                          icon: const Icon(Icons.delete,
                              color: Color.fromRGBO(53, 16, 79, 1), size: 28))
                    ],
                  ),
                ),
                const Divider(
                  indent: 16,
                  endIndent: 16,
                  color: Color.fromRGBO(53, 16, 79, 1),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                      "Start: ${trip.formatStartDate()} - End: ${trip.formatEndtDate()}",
                      style: const TextStyle(
                          color: Color.fromRGBO(45, 45, 45, 1))),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      "Leave from: ${trip.cityOfDeparture}",
                      style:
                          const TextStyle(color: Color.fromRGBO(45, 45, 45, 1)),
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: Text("Arrive in: ${trip.cityOfArrival}",
                        style: const TextStyle(
                            color: Color.fromRGBO(45, 45, 45, 1)))),
                Padding(
                  padding: const EdgeInsets.only(right: 12, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Ink(
                        decoration: const ShapeDecoration(
                            color: Color.fromRGBO(53, 16, 79, 1),
                            shape: CircleBorder()),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditTripScreen(trip: trip)));
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 24,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16)
      ],
    );
  }
}
