import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:triptaptoe_app/models/TicketDTO.dart';

class BodyTicket extends StatefulWidget {
  const BodyTicket({super.key});

  @override
  State<BodyTicket> createState() => _BodyTicketState();
}

final ticket1 = TicketDTO(
    idTicket: "id1",
    titoloTicket: "nomeViaggio1",
    path:
        "/data/user/0/com.example.triptaptoe_app/cache/file_picker/1712934271593/dummy.pdf",
    nomeFile: "nomeFile1");
final ticket2 = TicketDTO(
    idTicket: "id2",
    titoloTicket: "nomeViaggio2",
    path:
        "/data/user/0/com.example.triptaptoe_app/cache/file_picker/1712934271593/dummy.pdf",
    nomeFile: "nomeFile2");
final ticket3 = TicketDTO(
    idTicket: "id3",
    titoloTicket: "nomeViaggio3",
    path:
        "/data/user/0/com.example.triptaptoe_app/cachee_picker/1712934271593/dummy.pdf",
    nomeFile: "nomeFile3");

class _BodyTicketState extends State<BodyTicket> {
  List<TicketDTO> tickets = [ticket1, ticket2, ticket3];

  @override
  ScrollController _scrollController = ScrollController();

  Widget build(BuildContext context) {
    return Stack(
     
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 28, right: 28, top: 28),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   Text("Your Documents",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 36.0,
                        color: Color.fromRGBO(45, 45, 45, 1),
                      )),
                ],
              ),
             const SizedBox(height: 16),
              Expanded(
                  child: Scrollbar(
                controller: _scrollController,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: tickets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TicketCard(ticket: tickets[index]);
                  },
                ),
              )),
            ],
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTicket()),
              );
             
            },
            backgroundColor: const Color.fromRGBO(53, 16, 79, 1),
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class TicketCard extends StatefulWidget {
  const TicketCard({
    super.key,
    required this.ticket,
  });

  final TicketDTO ticket;
  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  late PDFViewController pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(255, 255, 255, 1),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.ticket.titoloTicket,
                  style: const TextStyle(fontSize: 18),
                ),
                const Icon(Icons.delete)
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Container(
              height: 150,
              width: 300,
              child: PDFView(
                filePath: widget.ticket.path,
                autoSpacing: true,
                enableSwipe: true,
                pageSnap: true,
                swipeHorizontal: true,
                onError: (error) {
                  print(error);
                },
                onPageError: (page, error) {
                  print('$page: ${error.toString()}');
                },
                onViewCreated: (PDFViewController vc) {
                  pdfViewController = vc;
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(children: [
              Text(widget.ticket.nomeFile, style: const TextStyle(fontSize: 18))
            ])
          ],
        ),
      ),
    );
  }
}

class AddTicket extends StatefulWidget {
  const AddTicket({super.key});

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  TextEditingController myController = TextEditingController();
  String _path = " ";
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color.fromRGBO(53, 16, 79, 1),
        leading: Padding(
          padding: const EdgeInsets.all(23.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      body: Padding(
        padding: const EdgeInsets.all(29.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Add a document",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
                color: Color.fromRGBO(45, 45, 45, 1),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Document title",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: TextField(
                controller: myController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Document title",
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                if (result != null) {
                  file = File(result.files.single.path!);
                  setState(() {
                    _path = file.toString();
                  });
                }
              },
              child: const Text('Seleziona un file'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DateTime now = DateTime.now();
          String formattedDate = DateFormat('yyyyMMddkkmmss').format(now);
          final ticketId = "ticket_$formattedDate";
          String nomeViaggio = myController.text;
          print("ticket ID = $ticketId");
          print("nome viaggio = $nomeViaggio");
          print("path file PDF = " + file.toString());
        },
        backgroundColor: const Color.fromRGBO(53, 16, 79, 1),
        shape: const CircleBorder(),
        child: const Icon(Icons.save, color: Colors.white),
      ),
    );
  }
}