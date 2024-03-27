import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarTrip extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected; // Funzione di callback

  const BottomNavigationBarTrip({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  State<BottomNavigationBarTrip> createState() => _BottomNavigationBarTripState();
}

class _BottomNavigationBarTripState extends State<BottomNavigationBarTrip> {
  late int _selectedNavbarItemIndex;

  @override
  void initState() {
    super.initState();
    _selectedNavbarItemIndex = widget.selectedIndex;
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedFontSize: 16,
      selectedItemColor: Color.fromRGBO(53,16,79,1),
      unselectedFontSize: 16,
      currentIndex: _selectedNavbarItemIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: "Budget"),
        BottomNavigationBarItem(icon: Icon(Icons.add_location_alt_outlined), label: "Itinerary"),
        BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_outlined), label: "Ticket"),
      ],
      onTap: (index) {
        setState(() {
          _selectedNavbarItemIndex = index;
        });
        widget.onItemSelected(index);
      },
    );
  }
}
