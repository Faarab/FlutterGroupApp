import 'package:flutter/material.dart';

class AddActivityModal extends StatelessWidget {
  const AddActivityModal({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: TextButton.icon(
        icon: const Icon(Icons.add),
        label: const Text("Add an activity"),
        onPressed: () {
          showModalBottomSheet(
            context: context, 
            isScrollControlled: true,
            builder: (BuildContext context){
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
                              icon: const  Icon(Icons.close, size: 32,)
                            ),
                          ],
                        ),
                        
                       
                      ],
                    ),
                  ),
                ),
              );
            }
          );
        },
      ),
    );
  }
}
