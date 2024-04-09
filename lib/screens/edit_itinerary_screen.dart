import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/screens/trip_details_screen.dart';
import '../widgets/edit_trip_body.dart';

class EditItineraryScreen extends StatelessWidget {
  EditItineraryScreen({super.key});

  final List<TripDTO> trips = [];

  
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
    
         body: const EditTripBody(), 
         floatingActionButton:ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) => Color.fromRGBO(53, 16, 79, 1)),
              overlayColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(199, 156, 230, 0.094)), 
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
            ),
            onPressed: () {
              // Inserire la logica di salvataggio qui
            },
            child: Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
          )                       
        );                
  }    
}
