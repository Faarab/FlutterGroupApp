import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _email = "belen.fernandez@gmail.com";
  late String _phoneNumber = "+34 359 682 9154";
  late String _country = "Spain";
  late bool isEmailBeingEdited = false;
  late bool isPhoneNumberBeingEdited = false;
  late bool isCountryBeingEdited = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 29, right: 29, top: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your profile",
                style: TextStyle(
                    color: Color.fromRGBO(45, 45, 45, 1),
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5, color: Colors.black38, spreadRadius: 2)
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/profile_picture.jpeg'),
                    radius: 50,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Belen Fernandez",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Expert traveller",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Form(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Email",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isEmailBeingEdited = true;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                        ))
                  ],
                ),
                isEmailBeingEdited
                    ? TextField(
                        decoration: InputDecoration(
                            hintText: "e.g. myemail@provider.com"),
                        onSubmitted: (value) => setState(() {
                          _email = value;
                          isEmailBeingEdited = false;
                        }),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            _email,
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(53, 16, 79, 1)),
                          ),
                          Divider()
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phone number",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isPhoneNumberBeingEdited = true;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                        ))
                  ],
                ),
                isPhoneNumberBeingEdited
                    ? TextField(
                        decoration:
                            InputDecoration(hintText: "e.g. +00 123 456 7890"),
                        onSubmitted: (value) => setState(() {
                          _phoneNumber = value;
                          isPhoneNumberBeingEdited = false;
                        }),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            _phoneNumber,
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(53, 16, 79, 1)),
                          ),
                          Divider()
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Country",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isCountryBeingEdited = true;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                        ))
                  ],
                ),
                isCountryBeingEdited
                    ? TextField(
                        decoration: InputDecoration(hintText: "e.g. Italy"),
                        onSubmitted: (value) => setState(() {
                          _country = value;
                          isCountryBeingEdited = false;
                        }),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            _country,
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(53, 16, 79, 1)),
                          ),
                          Divider()
                        ],
                      )
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class ProfileField extends StatefulWidget {
  ProfileField(
      {super.key,
      required this.isBeingEdited,
      required this.fieldHintText,
      required this.fieldText});

  String fieldHintText;
  bool isBeingEdited;
  String fieldText;

  @override
  State<ProfileField> createState() => _ProfileFieldState();
}

class _ProfileFieldState extends State<ProfileField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.isBeingEdited
            ? TextField(
                decoration: InputDecoration(hintText: widget.fieldHintText),
                onSubmitted: (value) => setState(() {
                  widget.fieldText = value;
                  widget.isBeingEdited = false;
                }),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.fieldText,
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(53, 16, 79, 1)),
                  ),
                  Divider()
                ],
              )
      ],
    );
  }
}
