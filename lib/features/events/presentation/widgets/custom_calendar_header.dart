// lib/widgets/calendar_header.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final VoidCallback onLeft;
  final VoidCallback onRight;
  final ValueChanged<DateTime> onTapMonth;

  const CalendarHeader({
    super.key,
    required this.focusedDay,
    required this.firstDay,
    required this.lastDay,
    required this.onLeft,
    required this.onRight,
    required this.onTapMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(icon: const Icon(Icons.chevron_left), onPressed: onLeft),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: focusedDay,
              firstDate: firstDay,
              lastDate: lastDay,
              initialDatePickerMode: DatePickerMode.day,
              helpText: 'Selecciona un mes',
            );
            if (picked != null) onTapMonth(picked);
          },
          child: Text(
            DateFormat.yMMMM('es').format(focusedDay).toUpperCase(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(icon: const Icon(Icons.chevron_right), onPressed: onRight),
      ],
    );
  }
}
