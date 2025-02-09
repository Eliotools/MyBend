import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/src/features/activity/activity_page.dart';
import 'package:mybend/src/features/home/home_cubit.dart';
import 'package:mybend/src/model/session.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class SessionContainer extends StatefulWidget {
  const SessionContainer({super.key, required this.sessions});

  final List<Session> sessions;

  @override
  State<SessionContainer> createState() => _SessionContainerState();
}

class _SessionContainerState extends State<SessionContainer> {
  Session? selected;
  @override
  Widget build(BuildContext context) => ListView(
        shrinkWrap: true,
        children: [
          widget.sessions.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.sessions
                      .map((e) => InkWell(
                          onTap: () => setState(() =>
                              selected == e ? selected = null : selected = e),
                          child: Text(
                            e.name,
                            style: TextStyle(
                                color: selected == e
                                    ? Colors.orange
                                    : Colors.white),
                          )))
                      .toList())
              : const Text(
                  "Pas d'exerces enregisté",
                  textAlign: TextAlign.center,
                ),
          CupertinoButton(
              child: const Text('Lancer'),
              onPressed: () => selected.isNull
                  ? null
                  : context
                      .pushNamed(
                        ActivityPage.name,
                        extra: selected!.list,
                      )
                      .then((value) => context.read<HomeCubit>().addHistory(
                          selected!.name, selected!.totalTime ~/ 6))),
        ],
      );
}
