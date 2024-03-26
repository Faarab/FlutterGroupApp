import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: SafeArea(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(child: Documents()),
    );
  }
}

class Documents extends StatefulWidget {
  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Color.fromRGBO(53, 16, 79, 1),
          leading: Padding(
            padding: EdgeInsets.all(23.0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(241, 241, 241, 1),
        body: Padding(
          padding: EdgeInsets.all(29.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Your documents",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: Color.fromRGBO(45, 45, 45, 1),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Card(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    elevation: 4,
                    child: SizedBox(height: 220),
                  )),
                ],
              ),
            ],
          ),
        ));
  }
}
