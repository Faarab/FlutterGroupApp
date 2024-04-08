import 'package:flutter/material.dart';

typedef DayChangeCallback = void Function(int newIndex);

class DaysNavigation extends StatelessWidget {
  const DaysNavigation({
    super.key,
    required this.dayIndex,
    required this.totalDays,
    required this.onBackward,
    required this.onForward,
  });

  final int dayIndex;
  final int totalDays;
  final DayChangeCallback onBackward;
  final DayChangeCallback onForward;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: dayIndex > 0 ? () => onBackward(dayIndex - 1) : null,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        Text(
          "Day ${dayIndex + 1}", 
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: dayIndex < totalDays - 1 ? () => onForward(dayIndex + 1) : null,
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
