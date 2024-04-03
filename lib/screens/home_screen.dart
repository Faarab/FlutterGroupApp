import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/main.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/widgets/home_screen_bottom_navigation_bar.dart';
import 'package:triptaptoe_app/widgets/trip_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final trip = TripDTO.fromJson(jsonDecode(tripJSON));
  final trip2 = TripDTO.fromJson(jsonDecode(tripJSON));
  final trip3 = TripDTO.fromJson(jsonDecode(tripJSON));
  List<TripDTO> tripArray = [];

  @override
  Widget build(BuildContext context) {
    tripArray = [];
    tripArray.add(trip);
    tripArray.add(trip2);
    tripArray.add(trip3);

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(53, 16, 79, 1),
        toolbarHeight: 64,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/images/logo.png",
              ))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Pressed floating button");
        },
        backgroundColor: Color.fromRGBO(53, 16, 79, 1),
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      bottomNavigationBar: HomeScreenBottomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 29, right: 29),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text("Your trips",
            //     style: TextStyle(
            //         color: Color.fromRGBO(45, 45, 45, 1),
            //         fontSize: 40,
            //         fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: tripArray.length,
                itemBuilder: (BuildContext context, int index) {
                  return TripCard(
                    trip: tripArray[index],
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

            // Container(
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.3),
            //         spreadRadius: 1,
            //         blurRadius: 2,
            //         offset: Offset(0, 2),
            //       ),
            //     ],
            //   ),
            //   child: Ink(
            //     padding: const EdgeInsets.all(8.0),
            //     decoration: const ShapeDecoration(
            //       color: Color.fromRGBO(53, 16, 79, 1),
            //       shape: CircleBorder(),
            //     ),
            //     child: IconButton(
            //       onPressed: () {},
            //       icon: const Icon(
            //         Icons.add,
            //         size: 32,
            //         color: Color.fromRGBO(255, 255, 255, 1),
            //       ),
            //     ),
            //   ),
            // ),
