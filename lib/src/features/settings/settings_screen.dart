import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mybend/src/enum/local_storage_key_enum.dart';
import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/helpers/local_storage_helper.dart';
import 'package:mybend/src/model/data_dto.dart';
import 'package:mybend/src/model/home_state.dart';
import 'package:mybend/src/shared/base_page.dart';
import 'package:mybend/src/shared/container.dart';

class SettingsPage extends BasePage<LocalStorageBloc, BendState> {
  const SettingsPage({super.key});

  static const name = 'settings';

  @override
  Widget onBuild(BuildContext context, BendState state) => switch (state) {
        BendLoaded<DataDto>(data: final data) => Column(
        children: [
          CustomContainer(
            child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Name'),
                const Gap(10),
                    Text(data.name ?? '??'),
                    CupertinoButton(
                        child: const Icon(Icons.refresh),
                        onPressed: () {
                          LocalStorageHelper.clearItem(
                              LocalStorageKeyEnum.name);
                          context.read<LocalStorageBloc>().getItems();
                        })
                  ],
                ),
              ),
              CustomContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('XP'),
                    const Gap(10),
                    Text(data.xp.toString()),
                    CupertinoButton(
                        child: const Icon(Icons.refresh),
                        onPressed: () {
                          LocalStorageHelper.clearItem(LocalStorageKeyEnum.xp);
                          context.read<LocalStorageBloc>().getItems();
                        }),
                    CupertinoButton(
                        child: const Icon(Icons.calculate),
                        onPressed: () {
                          LocalStorageHelper.calcXP();
                          context.read<LocalStorageBloc>().getItems();
                        }),
                  ],
                ),
              ),
              CustomContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('History'),
                    const Gap(10),
                    Text(data.history.length.toString()),
                    CupertinoButton(
                    child: const Icon(Icons.refresh),
                        onPressed: () {
                          LocalStorageHelper.clearItem(
                              LocalStorageKeyEnum.history);
                          context.read<LocalStorageBloc>().getItems();
                        }),
              ],
            ),
              ),
              CustomContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Streak'),
                    const Gap(10),
                    Text(data.streak?.streak.toString() ?? '0'),
                    CupertinoButton(
                        child: const Icon(Icons.refresh),
                        onPressed: () {
                          LocalStorageHelper.clearItem(
                              LocalStorageKeyEnum.streak);
                          context.read<LocalStorageBloc>().getItems();
                        }),
                  ],
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  LocalStorageHelper.clear();
                  context.read<LocalStorageBloc>().getItems();
                },
                child: const Icon(Icons.clear),
              ),
        ],
          ),
        _ => const SizedBox.shrink()
      };
}
