import 'package:flutter/material.dart';

class SuggestedActivities extends StatefulWidget {
  const SuggestedActivities({Key? key}) : super(key: key);

  @override
  State<SuggestedActivities> createState() => _SuggestedActivitiesState();
}

class _SuggestedActivitiesState extends State<SuggestedActivities> {
  Map<String, bool> filters = {
    "Museums": false,
    "Attractions": false,
    "Night Life": false,
    "Food": false,
    "Parks": false,
    "Shopping": false,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Suggested Activities",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: filters.entries
                  .map((filter) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: FilterChip(
                          backgroundColor: Colors.transparent,
                          label: Text(filter.key),
                          selected: filter.value,
                          onSelected: (selected) {
                            setState(() {
                              filters[filter.key] = selected;
                            });
                          },
                          selectedColor: Colors.purple,
                          labelStyle: TextStyle(
                            color: filter.value ? Colors.white : Colors.black,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 380,
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(10, (index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.asset(
                          "assets/images/img2.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sagrada Familia",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
//prova