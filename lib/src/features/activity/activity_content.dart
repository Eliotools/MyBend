import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/src/enum/local_storage_key_enum.dart';
import 'package:mybend/src/helpers/local_storage_helper.dart';
import 'package:mybend/src/model/activity.dart';

class ActivityContent extends StatefulWidget {
  const ActivityContent({required this.list, super.key});

  final List<Activity> list;

  @override
  State<ActivityContent> createState() => _ActivityContentState();
}

class _ActivityContentState extends State<ActivityContent> {
  final PageController _controller = PageController();
  int duration = 0;
  late int lvl;
  Timer? time;
  late Activity current;

  void nextPage(int index) {
    Future.delayed(Duration(seconds: widget.list[index].time + 5), () async {
      if (mounted) {
        setState(() => current = widget.list[index]);
        if (index < widget.list.length - 1) {
          FlutterRingtonePlayer().play(
            android: AndroidSounds.notification,
            ios: IosSounds.glass,
            looping: false,
            volume: 1,
            asAlarm: true,
          );
          await _controller
              .nextPage(
                duration: const Duration(seconds: 5),
                curve: Curves.easeOut,
              )
              .then((value) => setState(() => duration = 0));
        } else {
          close();
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    nextPage(0);
    lvl = (int.tryParse(LocalStorageHelper.getItemOrNull(LocalStorageKeyEnum.xp)
                .toString()) ??
            0) ~/
        1000;
    time = Timer.periodic(
        const Duration(milliseconds: 1), (_) => setState(() => duration += 1));
    current = widget.list.first;
  }

  @override
  void dispose() {
    super.dispose();
    time?.cancel();
  }

  void close() {
    time?.cancel();
    setState(() => duration = 0);
    context.pop();
  }

  @override
  Widget build(BuildContext context) => PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: nextPage,
        controller: _controller,
        children: widget.list
            .map<Widget>(
              (e) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    e.name,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(12),
                  Text(
                    '${e.time}s',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(45),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset('assets/sprites/lvl-${lvl + 1}/side.gif'),
                        Text(
                          '${(duration / 1000).toStringAsFixed(2)}s',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        LinearProgressIndicator(
                          value: (duration / 1000) / (current.time - 1),
                          color: Colors.orange,
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      );
}
