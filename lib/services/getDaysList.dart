import 'package:triptaptoe_app/models/DayDTO.dart';

List<DayDTO> getDaysList(DateTime startDate, DateTime endDate) {
  List<DayDTO> listOfDays = [];
  if (startDate == endDate) {
    DayDTO day = DayDTO(date: startDate);
    listOfDays.add(day);
  } else {
    List<DateTime> dateList = [];
    for (DateTime date = startDate;
        date.isBefore(endDate.add(Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
      dateList.add(date);
    }
    dateList.forEach((day) {
      listOfDays.add(DayDTO(date: day));
    });
  }

  return listOfDays;
}
