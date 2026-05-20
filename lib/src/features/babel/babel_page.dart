import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/features/modale/create_content_modale.dart';
import 'package:mybend/src/model/data_dto.dart';
import 'package:mybend/src/model/home_state.dart';
import 'package:mybend/src/shared/base_page.dart';
import 'package:flutter/material.dart';
import 'package:mybend/src/shared/extentions.dart';

class BabelPage extends BasePage<LocalStorageBloc, BendState> {
  const BabelPage({super.key});

  static const name = 'babel';

  @override
  Widget onBuild(BuildContext context, BendState state) => switch (state) {
        BendLoaded<DataDto>(data: final data) => Scaffold(
            appBar: AppBar(
              title: const Text('Babel'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        insetPadding: const EdgeInsets.all(8),
                        backgroundColor: context.them.colorScheme.surface,
                        child: const CreateContentModale(),
                      )),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            body: ListView.builder(
              itemCount: data.babel.length,
              itemBuilder: (context, index) => Text(data.babel[index].name),
            ),
          ),
        BendState() => Text(state.toString()),
      };
}
