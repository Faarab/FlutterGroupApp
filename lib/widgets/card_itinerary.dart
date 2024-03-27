import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/DayDTO.dart';
import 'package:triptaptoe_app/widgets/body_itenerary.dart';

class CardItinerary extends StatefulWidget {
  const CardItinerary({
    super.key,
    required this.widget,
    required this.day,
  });

  final BodyItenerary widget;
  final DayDTO day;

  @override
  State<CardItinerary> createState() => _CardItineraryState();
}

class _CardItineraryState extends State<CardItinerary> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: widget.day.cities!.length,
          itemBuilder: (BuildContext context, int index) {
            final city = widget.day.cities![index];
            return Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        city.name,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(1), // Bordo arrotondato della linea
                                ),
                              ),
                      ),
                    ]
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: city.activities!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final isFirstActivity = index == 0;
                      final activity = city.activities![index];
                      return ListTile(
                        title: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              textDirection: TextDirection.ltr,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.68,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                      activity.name,
                                      style: TextStyle(fontSize: 18,color: Color.fromRGBO(45, 45, 45, 1)),
                                      ),
                                      Text(
                                        activity.formatStartTime(),
                                        style: TextStyle(fontSize: 18,color: Color.fromRGBO(45, 45, 45, 1)),
                                        textAlign: TextAlign.end,
                                      ),
                                    ]
                                  ),
                                ),
                                Text(
                                  activity.location ?? "",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  activity.formatOpeningClosingTime(),
                                  style: TextStyle(fontSize: 14),
                                ),
                                Container(
                                  width: 120,
                                  height: 60,
                                  color: Colors.deepOrange,
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class WhiteCircleWithBorder extends StatelessWidget {
  const WhiteCircleWithBorder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
    );
  }
}
