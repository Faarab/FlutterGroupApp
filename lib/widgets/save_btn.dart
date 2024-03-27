import 'package:flutter/material.dart';

class SaveBtn extends StatelessWidget {
  const SaveBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) => Color.fromRGBO(53, 16, 79, 1)),
        overlayColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(199, 156, 230, 0.094)), 
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      ),
      onPressed: () {
        // Inserire la logica di salvataggio qui
      },
      child: Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
    );
  }
}
