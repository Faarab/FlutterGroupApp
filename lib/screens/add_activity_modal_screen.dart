import 'package:flutter/material.dart';

import '../widgets/suggested_activities.dart';

class AddActivityModal extends StatelessWidget {
  const AddActivityModal({super.key});

  @override
  Widget build(BuildContext context) {
    TimeOfDay? selectedTime; 

    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: TextButton.icon(
        icon: const Icon(Icons.add),
        label: const Text("Add an activity"),


        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
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
                            const SizedBox(width: 16),
                            Text("Madrid", style: TextStyle(fontSize: 24),),
                          ],
                        ),
                        const SizedBox(height: 16), 
                        Form(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Name",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: TextFormField(
                                      readOnly: true, 
                                      decoration: InputDecoration(
                                        labelText: "Time",
                                        border: OutlineInputBorder(),
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.access_time),
                                          onPressed: () async {
                                            selectedTime = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                                            if (selectedTime != null) {
                                              
                                              (context as Element).markNeedsBuild();
                                            }
                                          },
                                        ),
                                      ),
                                      controller: TextEditingController(
                                        text: selectedTime != null ? selectedTime!.format(context) : '', 
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Location",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20), 
                                  FloatingActionButton(
                                    onPressed: () {
                                     // aggiungere logica per il submit
                                    },
                                    child: Icon(Icons.check, color: Colors.white,),
                                      hoverColor: Color.fromRGBO(99, 31, 147, 1),
                                      backgroundColor: Color.fromRGBO(53, 16, 79, 1),
                                    shape: CircleBorder(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16), 
                        
                        SuggestedActivities()
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
