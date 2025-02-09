import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/src/features/activity/activity_content.dart';
import 'package:mybend/src/model/activity.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({required this.activities, super.key});

  static const name = 'activity';
  static const props = 'activities';

  final List<Activity> activities;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Scaffold(
        body: ActivityContent(list: activities),
        floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => context.pop()),
      ));
}
