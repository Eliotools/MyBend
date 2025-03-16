import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mybend/src/shared/container.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mybend/src/model/history.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

final dateFormat = DateFormat('d/MM');

class HistoryCalendarTab extends StatefulWidget {
  const HistoryCalendarTab({super.key, required this.data});

  final List<History> data;

  @override
  State<HistoryCalendarTab> createState() => _HistoryCalendarTabState();
}

class _HistoryCalendarTabState extends State<HistoryCalendarTab> {
  DateTime focusedDay = DateTime.now();

  List<History> selectedEvents = [];

  @override
  void initState() {
    super.initState();
    _updateSelectedEvents();
  }

  void _updateSelectedEvents() {
    setState(() {
      selectedEvents = widget.data
          .where((element) => isSameDay(element.date, focusedDay))
          .toList();
    });
  }

  Widget build(BuildContext context) => Column(children: [
        AspectRatio(
          aspectRatio: 1,
          child: TableCalendar(
            //hide format change button
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },

            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    bottom: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                      ),
                      width: 8.0,
                      height: 8.0,
                    ),
                  );
                }
                return null;
              },
            ),

            calendarStyle: const CalendarStyle(
              isTodayHighlighted: false,
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
            eventLoader: (day) {
              return widget.data
                  .where((element) =>
                      element.date?.day == day.day &&
                      element.date?.month == day.month &&
                      element.date?.year == day.year)
                  .toList();
            },

            locale: 'en',
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now(),
            focusedDay: focusedDay.subtract(const Duration(days: 2)),
            onDaySelected: (day, _) {
              setState(() {
                focusedDay = day;
              });
              _updateSelectedEvents();
            },
            //change focus day when user tap on a day

            selectedDayPredicate: (day) =>
                focusedDay.isAtSameMomentAs(day) ||
                widget.data.any((element) => element.date == day),
          ),
        ),
        Expanded(
          child: ListView(
            children: selectedEvents
                .map(
                  (e) => CustomContainer(
                    child: Row(
                      children: [
                        Row(
                          children: [
                            const Text('Le '),
                            e.date.isNotNull
                                ? Text(dateFormat.format(e.date!))
                                : const Text('/'),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(e.name),
                              Text(e.time?.toString() ?? 'nul'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        )
      ]);
}
