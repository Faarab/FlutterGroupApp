import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip});

  final TripDTO trip;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
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
                    style:
                        const TextStyle(color: Color.fromRGBO(45, 45, 45, 1))),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    "Leave from: " + trip.cityOfDeparture,
                    style: TextStyle(color: Color.fromRGBO(45, 45, 45, 1)),
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 16, top: 8),
                  child: Text("Arrive in: " + trip.cityOfArrival,
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
                          onPressed: () {},
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
        SizedBox(height: 16)
      ],
    );
  }
}
