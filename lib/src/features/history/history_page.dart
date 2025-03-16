import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/model/data_dto.dart';
import 'package:mybend/src/model/home_state.dart';
import 'package:mybend/src/shared/base_page.dart';
import 'package:mybend/src/shared/container.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

final dateFormat = DateFormat('d/MM');

class HistoryScreen extends BasePage<LocalStorageBloc, BendState> {
  const HistoryScreen({super.key});

  static const name = 'history';

  @override
  Widget onBuild(BuildContext context, BendState state) => switch (state) {
        BendLoaded<DataDto>(data: final data) => data.history.isNotEmpty
            ? ListView.builder(
                itemCount: data.history.length,
                itemBuilder: (context, index) => CustomContainer(
                      child: Row(
              children: [
                Row(
                  children: [
                              const Text('Le '),
                              data.history[index].date.isNotNull
                                  ? Text(dateFormat
                                      .format(data.history[index].date!))
                                  : const Text('/'),
                            ],
                ),
                Expanded(
                  child: Column(
                    children: [
                                Text(data.history[index].name),
                                Text(data.history[index].time?.toString() ??
                                    'nul'),
                    ],
                  ),
                ),
              ],
            ),
                    ))
            : const Text('No History'),
        BendState() => const Text('No History'),
      };
}

