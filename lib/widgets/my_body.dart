import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/CityDTO.dart';

class MyBody extends StatefulWidget {
  const MyBody({super.key, required this.activity});

  final Widget activity;

  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  TextEditingController _cityController = TextEditingController();
  List<CityDTO> _addedCities = [];
  bool _isAddingCity = false;

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 29, right: 29),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text(
            "Edit Itinerary",
            style: TextStyle(
              color: Color.fromRGBO(45, 45, 45, 1),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          _buildDayNavigation(),
          const SizedBox(height: 30),
          if (_isAddingCity || _addedCities.isNotEmpty) _buildAddedCities(),
          const SizedBox(height: 10),
          _buildCityCard(),
        ],
      ),
    );
  }

  Widget _buildDayNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
        const Text("Day 1"),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  Widget _buildAddedCities() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _addedCities.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.radio_button_unchecked),
                    const SizedBox(width: 30),
                    Text(
                      _addedCities[index].name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => widget.activity));
                        },
                        icon: Icon(Icons.add),
                        label: Text("Add an activity"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildCityCard() {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          if (!_isAddingCity)
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _isAddingCity = true;
                });
              },
              icon: Icon(Icons.add),
              label: Text("Add a city"),
            ),
          if (_isAddingCity)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a city',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        _addedCities.add(CityDTO(name: value));
                        _cityController.clear();
                        _isAddingCity = false;
                      });
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isAddingCity = false;
                    });
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
