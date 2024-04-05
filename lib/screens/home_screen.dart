import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/main.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/widgets/home_screen_bottom_navigation_bar.dart';
import 'package:triptaptoe_app/widgets/trip_card.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TripDTO> tripArray = [];

  //Read the JSON file content and set the array to the list in the JSON
  //This makes it so that you read the JSON file and can then display a card for each trip
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/images/sample.json');
    final Map<String, dynamic> data = await json.decode(response);
    List<dynamic> dynamicTripsList = data["trips"];
    var tripsList = dynamicTripsList.map(
      (e) {
        return TripDTO.fromJson(e);
      },
    ).toList();
    setState(() {
      tripArray = tripsList;
    });
  }

  Future<void> readAndWriteJson() async {
    final myDirectory = await getApplicationDocumentsDirectory();
    final myPath = myDirectory.path;
    //print(myPath);
    final myFile = File('$myPath/trips.json');

    final contents = await myFile.readAsString();
    if (contents != "") {
      final Map<String, dynamic> contentsJSON = jsonDecode(contents);
      print(contentsJSON['cityOfDeparture']);
    }
  }

  @override
  Widget build(BuildContext context) {
    //readJson();
    readAndWriteJson();
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
