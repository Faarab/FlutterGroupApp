import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/widgets/my_app_bar.dart';
import 'package:triptaptoe_app/widgets/save_btn.dart';

import '../widgets/my_body.dart';

class EditItineraryScreen extends StatelessWidget {
  EditItineraryScreen({super.key});

  final List<TripDTO> trips = [];

  
  @override
  Widget build(BuildContext context) {
    return 
        Scaffold(
          backgroundColor: Colors.white,
          appBar: MyAppBar(
            goBack: Scaffold(body: Text("Create a new trip"),),
          ),
         body: MyBody(activity: Scaffold(body: Text("Activity Overlay")),), 
         floatingActionButton: SaveBtn(),                       
        );                
  }    
}
