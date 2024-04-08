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
    Key? key,
    required this.trip,
  }) : super(key: key);
  
  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  int _selectedNavbarItemIndex = 1; // Inizializza l'indice selezionato

  late Widget _body = BodyItenerary(widget: widget); // Inizializza il corpo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackArrow(screen: Fake()),
      body: Padding(
        padding: const EdgeInsets.only(right: 29.0, left: 29.0, top: 24.0, bottom: 30.0),
        child: _body,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow:[ 
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: Offset(0, -1),
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
                  _body = Center(
                    child: Text("Pagina budget"),
                  );
                  break;
                case 1:
                  _body = BodyItenerary(widget: widget);
                  break;
                case 2:
                  _body = Center(
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
