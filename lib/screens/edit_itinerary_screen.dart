import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/screens/trip_details_screen.dart';
import '../widgets/edit_itinerary_body.dart';

class EditItineraryScreen extends StatefulWidget {
  EditItineraryScreen({super.key, required this.trip});
  final TripDTO trip;

  @override
  State<EditItineraryScreen> createState() => _EditItineraryScreenState();
}

class _EditItineraryScreenState extends State<EditItineraryScreen> {

  @override
  Widget build(BuildContext context) {
    return 
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
      
            leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const TripDetailsScreen()));
            },
      ),
      backgroundColor: const Color.fromRGBO(99, 31, 147, 1),
      toolbarHeight: 64,
    ),
    
         body: EditItineraryBody(widget: widget, trip: widget.trip,), 
                      
        );                
  }    
}
