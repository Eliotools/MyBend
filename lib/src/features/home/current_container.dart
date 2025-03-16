import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/src/enum/local_storage_key_enum.dart';
import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/features/modale/add_activity_modale.dart';
import 'package:mybend/src/helpers/local_storage_helper.dart';
import 'package:mybend/src/model/activity.dart';
import 'package:mybend/src/shared/container.dart';
import 'package:mybend/src/shared/extentions.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class CurrentContainer extends StatelessWidget {
  const CurrentContainer({super.key, this.current});

  final Activity? current;

  @override
  Widget build(BuildContext context) => CustomContainer(
      child: current.isNull
          ? CupertinoButton(
              child: const Text("Commencer une activité"),
              onPressed: () => LocalStorageHelper.setItem(
                  LocalStorageKeyEnum.current,
                  Activity(
                          name: 'Current',
                          time: DateTime.now().millisecondsSinceEpoch)
                      .toJson()))
          : CupertinoButton(
              child: Text("Stop Current activity ${current!.time}"),
              onPressed: () async => showDialog(
                  context: context,
                  builder: (context) => Dialog(
                      insetPadding: const EdgeInsets.all(8),
                      backgroundColor: context.them.colorScheme.surface,
                      child: AddActivityModale(
                        time: (DateTime.now().millisecondsSinceEpoch -
                                current!.time) ~/
                            1000,
                      ))).then((value) {
                LocalStorageHelper.clearItem(LocalStorageKeyEnum.current);
                context.read<LocalStorageBloc>().getItems();
              }),
            ));
}
