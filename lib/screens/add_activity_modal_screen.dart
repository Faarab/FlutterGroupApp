import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/ActivityDTO.dart';

import '../widgets/suggested_activities.dart';

//TODO 

//capire come sistemare la questione campi non required (ex image) per quanto riguarda l'itinerario
//inserire logica per salvare dati in file json
//sistemare inserimento attività per singola città
//sistemare la questione scorrimento tra giorni
//sistemare secondo numero dei minuti
//implementare logica schermata edit trip
//scorrimento città + attività
//font size ecc
//navigator check

class AddActivityModal extends StatefulWidget {
  const AddActivityModal({super.key, required this.onActivityAdded});

  final Function(ActivityDTO) onActivityAdded;

  @override
  State<AddActivityModal> createState() => _AddActivityModalState();
}

class _AddActivityModalState extends State<AddActivityModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = "";
  String _location = "";
  DateTime? _selectedDateTime;

  late TextEditingController _nameController;
  late TextEditingController _locationController;

  @override
  void initState() {
    
    super.initState();

    _nameController = TextEditingController();
    _locationController = TextEditingController();
  } 

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add an activity",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close, size: 32,),
                  ),
                ],
              ),
              const SizedBox(height: 16), 
              const Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 16),
                  //TODO ricordarsi di far sì che il nome della città cambi dinamicamente
                  Text("Barcelona", style: TextStyle(fontSize: 24),),
                ],
              ),
              const SizedBox(height: 16), 
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: "Name",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a name";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _name = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            readOnly: true, 
                            validator: (value) {
                              if (value==null || value.isEmpty){
                              return "Please enter a starting time";}
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Time",
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.access_time),
                                onPressed: () async {
                                  final selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (selectedTime != null) {
                                    setState(() {
                                      _selectedDateTime = DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                        selectedTime.hour,
                                        selectedTime.minute,
                                      );
                                    });
                                  }
                                },
                              ),
                            ),
                            controller: TextEditingController(
                              text: _selectedDateTime != null ? _selectedDateTime!.hour.toString().padLeft(2, '0') + ':' + _selectedDateTime!.minute.toString().padLeft(2, '0') : '', 
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _locationController,
                            decoration: const InputDecoration(
                              labelText: "Location",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a location";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _location = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 20), 
                        FloatingActionButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final newActivity = ActivityDTO(
                                name: _name,
                                startTime: _selectedDateTime!,
                                openingTime: null, 
                                closingTime: null, 
                                location: _location, 
                                price: null, 
                                image: null, 
                                category: null, 
                              );
                              widget.onActivityAdded(newActivity);
                              Navigator.pop(context);
                            }
                          },
                          
                          hoverColor: const Color.fromRGBO(99, 31, 147, 1),
                          backgroundColor: const Color.fromRGBO(53, 16, 79, 1),
                          shape: const CircleBorder(),
                          child: const Icon(Icons.check, color: Colors.white,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16), 
              SuggestedActivities(onActivityTapped: (ActivityDTO activity) {
                setState(() {
                  _name = activity.name;
                  _location = activity.location ?? "";
                  _nameController.text = _name;
                 _locationController.text = _location;
                });
                
              },)
            ],
          ),
        ),
      ),
    );
  }
}
