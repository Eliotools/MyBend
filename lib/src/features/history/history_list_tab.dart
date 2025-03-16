import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/src/enum/local_storage_key_enum.dart';
import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/helpers/local_storage_helper.dart';
import 'package:mybend/src/model/history.dart';
import 'package:mybend/src/shared/container.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:intl/intl.dart' show DateFormat;

final dateFormat = DateFormat('d/MM');

class HistoryListTab extends StatelessWidget {
  const HistoryListTab({super.key, required this.data});

  final List<History> data;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => CustomContainer(
          child: Dismissible(
            key: Key(data[index].name),
            onDismissed: (direction) {
              LocalStorageHelper.removeIndex(
                  LocalStorageKeyEnum.history, index);
              LocalStorageHelper.calcXP();
              context.read<LocalStorageBloc>().getItems();
            },
            child: Row(
              children: [
                Row(
                  children: [
                    const Text('Le '),
                    data[index].date.isNotNull
                        ? Text(dateFormat.format(data[index].date!))
                        : const Text('/'),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(data[index].name),
                      Text(data[index].time?.toString() ?? 'nul'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
