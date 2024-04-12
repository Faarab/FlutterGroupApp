import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/main.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/screens/fake_screen.dart';
import 'package:triptaptoe_app/widgets/app_bar_with_back_arrow.dart';
import 'package:triptaptoe_app/widgets/body_itenerary.dart';
import 'package:triptaptoe_app/widgets/bottom_navigation_bar_trip.dart';

class ItineraryScreen extends StatefulWidget {
  final TripDTO trip;
  const ItineraryScreen({
    super.key,
    required this.trip,
  });
  
  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  int _selectedNavbarItemIndex = 1; // Inizializza l'indice selezionato

  late Widget _body = BodyItenerary(widget: widget); // Inizializza il corpo
  late String? _title;
  @override
  void initState() {
    super.initState();
    _title = widget.trip.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackArrow(title: _title),
      body: Padding(
        padding: const EdgeInsets.only(right: 29.0, left: 29.0, top: 24.0, bottom: 30.0),
        child: _body,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow:[ 
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(0, -1),
            )
          ],
        ),
        child: BottomNavigationBarTrip(
          selectedIndex: _selectedNavbarItemIndex,
          onItemSelected: (index) {
            setState(() {
              _selectedNavbarItemIndex = index; // Aggiorna l'indice selezionato

              // Modifica il corpo in base all'indice selezionato
              switch (_selectedNavbarItemIndex) {
                case 0:
                  _body = const Center(
                    child: Text("Pagina budget"),
                  );
                  break;
                case 1:
                  _body = BodyItenerary(widget: widget);
                  break;
                case 2:
                  _body = const Center(
                    child: Text("Pagina Ticket"),
                  );
                  break;
                default:
                  _body = BodyItenerary(widget: widget);
              }
            });
          },
        ),
      ),
    );
  }
}
