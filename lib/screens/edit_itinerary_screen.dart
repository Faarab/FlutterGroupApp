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
    late Widget _body = EditItineraryBody(widget: widget); // Inizializza il corpo

  @override
  Widget build(BuildContext context) {
    return 
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
      
            leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const TripDetailsScreen()));
            },
      ),
      backgroundColor: Color.fromRGBO(99, 31, 147, 1),
      toolbarHeight: 64,
    ),
    
         body: _body, 
         floatingActionButton:ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) => Color.fromRGBO(53, 16, 79, 1)),
              overlayColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(199, 156, 230, 0.094)), 
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
            ),
            onPressed: () {
              // Inserire la logica di salvataggio 
            },
            child: Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
          )                       
        );                
  }    
}
