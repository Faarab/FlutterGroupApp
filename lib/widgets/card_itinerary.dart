import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:triptaptoe_app/models/DayDTO.dart';
import 'package:triptaptoe_app/services/OpenGoogleMaps.dart';
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
    print(widget.day.toString());
    return Expanded(
      child: Card(
        elevation: 4,
        child: widget.day.cities == null || widget.day.cities!.isEmpty
            ? ListView.builder(
                controller: _scrollController,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return const Center(
                    child: Column(children: [
                      SizedBox(height: 32),
                      Text(
                        'This day it\'s empty, you need to add some cities and activities',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                    ]),
                  );
                })
            : ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                itemCount:
                    widget.day.cities == null ? 0 : widget.day.cities!.length,
                itemBuilder: (BuildContext context, int index) {
                  final city = widget.day.cities![index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(
                            city.name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 1,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(
                                    1), // Bordo arrotondato della linea
                              ),
                            ),
                          ),
                        ]),
                        city.activities!.isEmpty
                            ? const Center(
                                child: Column(children: [
                                  SizedBox(height: 32),
                                  Text(
                                    'No activities yet',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: city.activities!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final isFirstActivity = index == 0;
                                  final isLastActivity =
                                      index == city.activities!.length - 1;
                                  final activity = city.activities![index];
                                  String? location = activity.location;
                                  if (location != null) {
                                    if (location.length > 20) {
                                      location =
                                          '${location.substring(0, 20)}...';
                                    }
                                  } else {
                                    location = '';
                                  }
                                  return TimelineTile(
                                    isFirst: isFirstActivity,
                                    isLast: isLastActivity,
                                    alignment: TimelineAlign.start,
                                    indicatorStyle: IndicatorStyle(
                                      indicatorXY: 0.13,
                                      width: 18,
                                      color:
                                          const Color.fromRGBO(53, 16, 79, 1),
                                      indicator: Container(
                                        // Personalizza il contenuto dell'indicatore
                                        alignment: Alignment.topCenter,
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color.fromRGBO(53, 16,
                                                79, 1), // Colore del bordo
                                            width: 2, // Spessore del bordo
                                          ),
                                          color: Colors
                                              .white, // Colore interno bianco
                                        ),
                                      ),
                                    ),
                                    beforeLineStyle: const LineStyle(
                                      color: Color.fromRGBO(53, 16, 79, 1),
                                      thickness: 5,
                                    ),
                                    endChild: ListTile(
                                      title: Row(children: [
                                        Text(
                                          activity.name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Color.fromRGBO(
                                                  45, 45, 45, 1)),
                                        ),
                                        activity.location != "" ||
                                                activity.location != null
                                            ? IconButton(
                                                onPressed: () {
                                                  openGoogleMaps(
                                                      activity.location ?? "");
                                                },
                                                icon: const Icon(Icons.directions,
                                                    color: Color.fromRGBO(
                                                        53, 16, 79, 1),
                                                    size: 24),
                                                iconSize: 32,
                                                color: Colors.white,
                                              )
                                            : Container(),
                                      ]),
                                      subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              location,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                            Text(
                                              activity
                                                  .formatOpeningClosingTime(),
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            activity.image != null &&
                                                    activity.image!.isNotEmpty
                                                ? Container(
                                                    width: 160,
                                                    height: 80,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 16),
                                                    child: Image.asset(
                                                      "assets/images/${activity.image}",
                                                      fit: BoxFit.cover,
                                                    ))
                                                : Container(),
                                         
                                          ]),
                                      trailing: Text(
                                        activity.formatStartTime(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(45, 45, 45, 1)),
                                      ),
                                      titleAlignment:
                                          ListTileTitleAlignment.titleHeight,
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
