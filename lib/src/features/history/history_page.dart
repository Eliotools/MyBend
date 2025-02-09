import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'package:localstorage/localstorage.dart';
import 'package:mybend/src/shared/container.dart';

final dateFormat = DateFormat('d/MM');

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  static const name = 'history';

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late List<Object?> history;

  @override
  void initState() {
    history =
        jsonDecode(localStorage.getItem('history') ?? '[]') as List<Object?>;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: history.map((e) {
          e as Map<String, Object?>;
          return CustomContainer(
            child: Row(
              children: [
                Row(
                  children: [
                    const Text('Le '),
                    Text(dateFormat.format(
                        DateTime.fromMillisecondsSinceEpoch(e['date'] as int))),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(e['name'].toString()),
                      Text(e['time'].toString()),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
}
