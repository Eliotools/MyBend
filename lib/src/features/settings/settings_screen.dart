import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybend/src/enum/local_storage_key_enum.dart';
import 'package:mybend/src/helpers/local_storage_bloc.dart';
import 'package:mybend/src/model/activity.dart';
import 'package:mybend/src/model/session.dart';
import 'package:mybend/src/shared/container.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const name = 'settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? name;
  List<Activity>? exercies = [];
  List<Session>? sessions = [];
  int xp = 0;
  int? last;

  void getItems() {
    exercies = (LocalStorageHelper.getItemOrNull(LocalStorageKeyEnum.exercices,
                parse: true) as List?)
            ?.map((e) => Activity.fromJson(e as Map<String, Object?>))
            .toList() ??
        [];
    sessions = (LocalStorageHelper.getItemOrNull(LocalStorageKeyEnum.sessions,
                parse: true) as List?)
            ?.map((e) => Session.fromJson(e as Map<String, Object?>))
            .toList() ??
        [];
    name =
        LocalStorageHelper.getItemOrNull(LocalStorageKeyEnum.name) as String?;
    xp = int.tryParse(LocalStorageHelper.getItemOrNull(LocalStorageKeyEnum.xp)
            .toString()) ??
        0;
    last = ((LocalStorageHelper.getItemOrNull(LocalStorageKeyEnum.history,
            parse: true) as List)
        .last as Map<String, Object?>)['time'] as int;
    setState(() {
      exercies;
      sessions;
      name;
      xp;
      last;
    });
  }

  @override
  void initState() {
    getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          CustomContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Name'),
                Text(name ?? ''),
                CupertinoButton(
                    child: const Icon(Icons.refresh),
                    onPressed: () =>
                        LocalStorageHelper.clearItem(LocalStorageKeyEnum.name))
              ],
            ),
          ),
          CustomContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('XP'),
                Text(xp.toString()),
                CupertinoButton(
                    child: const Icon(Icons.refresh),
                    onPressed: () =>
                        LocalStorageHelper.clearItem(LocalStorageKeyEnum.xp))
              ],
            ),
          )
        ],
      );
}
