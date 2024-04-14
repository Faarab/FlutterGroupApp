import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 29, right: 29, top: 24),
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
            children: [
              CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/profile_picture.jpeg'),
                radius: 50,
              ),
            ],
          )
        ],
      ),
    );
  }
}
