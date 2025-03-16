import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mybend/src/model/history.dart';
import 'package:intl/intl.dart';

class HistoryGraphTab extends StatefulWidget {
  const HistoryGraphTab({super.key, required this.data});

  final List<History> data;
  @override
  State<HistoryGraphTab> createState() => _HistoryGraphTabState();
}

class _HistoryGraphTabState extends State<HistoryGraphTab> {
  late List<FlSpot> activityByDay;
  DateTime selectedDate = DateTime.now();

  List<FlSpot> getActivityByDayByMonth(int month) {
    final data = widget.data.where((e) => e.date?.month == month).toList();
    final result =
        List.generate(DateTime(selectedDate.year, month + 1, 0).day, (index) {
      final xpSom = data
          .where((e) => e.date?.day == index + 1)
          .fold(0, (previousValue, element) => previousValue + element.time!);
      return FlSpot(index.toDouble(), xpSom.toDouble());
    });
    return result;
  }

  @override
  void initState() {
    super.initState();
    activityByDay = getActivityByDayByMonth(selectedDate.month);
  }

  switchMonth(int month) {
    setState(() {
      selectedDate = DateTime(selectedDate.year, month, 1);
    });
    activityByDay = getActivityByDayByMonth(selectedDate.month);
    setState(() => activityByDay);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  switchMonth(selectedDate.month - 1);
                },
              ),
              Text(
                DateFormat('MMMM yyyy').format(selectedDate),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  switchMonth(selectedDate.month + 1);
                },
              ),
            ],
          ),
          AspectRatio(
            aspectRatio: 1,
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      interval: 1,
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final data =
                            activityByDay.where((e) => e.x == value).first;
                        if (data.y == 0) {
                          return const Text('');
                        }
                        return Text(
                          '${data.x.toInt()}/${selectedDate.month.toString().padLeft(2, '0')}',
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: activityByDay,
                    dotData: FlDotData(
                      show: true,
                      checkToShowDot: (spot, barData) => spot.y != 0,
                    ),
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
