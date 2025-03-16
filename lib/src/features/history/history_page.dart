import 'package:flutter/material.dart';

import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/features/history/history_calendar_tab.dart';
import 'package:mybend/src/features/history/history_graph_tab.dart';
import 'package:mybend/src/features/history/history_list_tab.dart';
import 'package:mybend/src/model/data_dto.dart';
import 'package:mybend/src/model/home_state.dart';
import 'package:mybend/src/shared/base_page.dart';


class HistoryScreen extends BasePage<LocalStorageBloc, BendState> {
  const HistoryScreen({super.key});

  static const name = 'history';

  @override
  Widget onBuild(BuildContext context, BendState state) => switch (state) {
        BendLoaded<DataDto>(data: final data) => data.history.isNotEmpty
            //implement tab bar to switch between deferent history view
            ? DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('History'),
                    bottom: const TabBar(
                      indicatorWeight: 5,
                      dividerColor: Colors.orange,
                      indicatorColor: Colors.orange,
                      tabs: [
                        Tab(icon: Icon(Icons.list)),
                        Tab(icon: Icon(Icons.bar_chart)),
                        Tab(icon: Icon(Icons.calendar_month)),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      HistoryListTab(data: data.history),
                      HistoryGraphTab(data: data.history),
                      HistoryCalendarTab(data: data.history),
                    ],
                  ),
                ))
            : const Text('No History'),
        BendState() => const Text('No History'),
      };
}

