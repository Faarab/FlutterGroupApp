import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/screens/edit_trip_screen.dart';
import 'package:triptaptoe_app/screens/itinerary_screen.dart';

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip, required this.index});

  final TripDTO trip;
  final int index;

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
                          onPressed: () {},
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
