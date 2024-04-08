import 'package:flutter/material.dart';

class HomeScreenBottomNavigationBar extends StatefulWidget {
  const HomeScreenBottomNavigationBar({super.key, required this.onPressed});

  final Function(int) onPressed;

  @override
  State<HomeScreenBottomNavigationBar> createState() =>
      _HomeScreenBottomNavigationBarState();
}

class _HomeScreenBottomNavigationBarState
    extends State<HomeScreenBottomNavigationBar> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      widget.onPressed(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 16,
        unselectedFontSize: 16,
        backgroundColor: Color.fromRGBO(241, 241, 241, 1),
        selectedItemColor: Color.fromRGBO(53, 16, 79, 1),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.currency_exchange,
              ),
              label: "Exchange"),
          BottomNavigationBarItem(
              icon: Icon(Icons.airplanemode_active), label: "Trips"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: "Profile"),
        ]);
  }
}
