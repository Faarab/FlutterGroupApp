import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/CityDTO.dart';

class CityCard extends StatefulWidget {
  CityCard(
      {super.key,
      required this.hardcodedcitieslist,
      required this.citiesPerDay,
      required this.currentDayIndex,
      required this.isAddingCity,
      this.onCitySelected});
  bool isAddingCity = false;
  final List<CityDTO> hardcodedcitieslist;

  final List<List<CityDTO>> citiesPerDay;

  final int currentDayIndex;

  final Function(CityDTO)? onCitySelected;

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            if (!widget.isAddingCity)
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        setState(() {
                          widget.isAddingCity = true;
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity, 50)),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          alignment: Alignment.centerLeft),
                      label: const Text("Add a city",
                          style: TextStyle(color: Colors.black, fontFamily: 'Poppins' , fontSize: 16)),
                      icon: const Icon(Icons.add, color: Colors.black),
                    ),
                  ),
                ],
              ),
            if (widget.isAddingCity)
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Autocomplete<CityDTO>(
                        optionsBuilder: (textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<CityDTO>.empty();
                      } else {
                        return widget.hardcodedcitieslist.where((CityDTO city) {
                          return city.name
                              .toLowerCase()
                              .startsWith(textEditingValue.text.toLowerCase());
                        });
                      }
                    }, fieldViewBuilder: (fbContext, textEditingController,
                            focusNode, onFieldSubmitted) {
                      return TextField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          hintText: 'Enter a city',
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        onSubmitted: (value) {
                          final selectedCity = widget.hardcodedcitieslist
                              .firstWhere((city) => city.name == value,);

                          setState(() {
                            widget.citiesPerDay[widget.currentDayIndex]
                                .add(selectedCity);
                            textEditingController.clear();
                            widget.isAddingCity = false;
                          });
                        },
                      );
                    }, optionsViewBuilder: (optcontext, onSelected, cities) {
                      return Material(
                        color: Colors.transparent,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          itemCount: cities.length,
                          itemBuilder: (BuildContext context, int index) {
                            final city = cities.elementAt(index);
                            return ListTile(
                              leading: const Icon(Icons.location_on),
                              title: Text(
                                city.name, style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                              ),
                              subtitle: Text(city.country ?? 'N/A'),
                              onTap: () {
                                onSelected(city);
                              },
                            );
                          },
                        ),
                      );
                    }, onSelected: (CityDTO city) {
                      if (widget.onCitySelected != null) {
                        widget.onCitySelected!(city);
                      }
                    }),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isAddingCity = false;
                      });
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
