import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:triptaptoe_app/models/DayDTO.dart';
import 'package:triptaptoe_app/widgets/body_itenerary.dart';

class CardItinerary extends StatefulWidget {
  const CardItinerary({
    super.key,
    required this.widget,
    required this.day,
    required this.scrollController,
  });

  final ScrollController scrollController;
  final BodyItenerary widget;
  final DayDTO day;

  @override
  State<CardItinerary> createState() => _CardItineraryState();
}

class _CardItineraryState extends State<CardItinerary> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController;
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: ListView.builder(
          controller: _scrollController,
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
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                      final isLastActivity = index == city.activities!.length - 1;
                      final activity = city.activities![index];
                      return TimelineTile(
                        isFirst: isFirstActivity,
                        isLast: isLastActivity,
                        alignment: TimelineAlign.start,
                        indicatorStyle: IndicatorStyle(
                          indicatorXY: 0.13,
                          width: 18,
                          color: Color.fromRGBO(53,16,79,1),
                          indicator: Container( // Personalizza il contenuto dell'indicatore
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color.fromRGBO(53, 16, 79, 1), // Colore del bordo
                                width: 2, // Spessore del bordo
                              ),
                              color: Colors.white, // Colore interno bianco
                            ),
                          ),
                        ),
                        beforeLineStyle: LineStyle(
                          color: Color.fromRGBO(53,16,79,1),
                          thickness: 3,
                        ),
                        endChild: ListTile(
                          title: Text(
                            activity.name,
                            style: TextStyle(fontSize: 18, color: Color.fromRGBO(45, 45, 45, 1)),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activity.location ?? "",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                activity.formatOpeningClosingTime(),
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 8,),
                              Container(
                                width: 160,
                                height: 80,
                                color: Colors.amber,
                                margin: EdgeInsets.only(bottom: 16),
                              )
                            ],
                          ),
                          trailing: Text(
                            activity.formatStartTime(),
                            style: TextStyle(fontSize: 18, color: Color.fromRGBO(45, 45, 45, 1)),
                          ),
                          titleAlignment: ListTileTitleAlignment.top,
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
