import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/widgets/app_bar_with_back_arrow.dart';
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
    return Scaffold(
      appBar: const AppBarWithBackArrow(),
      body: EditItineraryBody(
        widget: widget,
        trip: widget.trip,
      ),
    );
  }
}
