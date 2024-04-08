import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/main.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/widgets/home_screen_bottom_navigation_bar.dart';
import 'package:triptaptoe_app/widgets/trip_card.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'trip_details_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<TripDTO>>? tripArray;

  @override
  void initState() {
    super.initState();
    tripArray = readJson();
  }

  Future<List<TripDTO>> readJson() async {
    final myDirectory = await getApplicationDocumentsDirectory();
    final myPath = myDirectory.path;
    print(myPath);
    final myFile = File('$myPath/trips.json');
    //myFile.writeAsString("");
    final contents = await myFile.readAsString();
    if (contents != "") {
      final Map<String, dynamic> contentsJSON = jsonDecode(contents);
      print(contentsJSON);

      List<dynamic> dynamicTripsList = contentsJSON['trips'];
      print(dynamicTripsList);
      final List<TripDTO> tripsList = dynamicTripsList.map(
        (e) {
          return TripDTO.fromJson(e);
        },
      ).toList();
      print(tripsList);
      return tripsList;
      // setState(() {
      //   tripArray = tripsList;
      // });
    } else {
      print("File is empty");
      return <TripDTO>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    //readJson();
    readJson();
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
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
        onPressed: () => {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TripDetailsScreen()),
          )
        },
        hoverColor: Color.fromRGBO(99, 31, 147, 1),
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
            FutureBuilder<List<TripDTO>>(
              future: readJson(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: (snapshot.data!).length,
                        itemBuilder: (context, index) {
                          return TripCard(
                              trip: snapshot.data![index], index: index);
                        },
                      ),
                    );
                  } else {
                    return Expanded(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 240,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "There are no trips yet.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(45, 45, 45, 1)),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "You can add a trip by clicking on the '+' button",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(45, 45, 45, 1)),
                              )
                            ],
                          ),
                        )
                      ],
                    ));
                  }
                } else {
                  return Container();
                }
              },
            )
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: tripArray.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return TripCard(
            //         trip: tripArray[index],
            //         index: index,
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
