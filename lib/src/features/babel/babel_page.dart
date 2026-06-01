import 'package:go_router/go_router.dart';
import 'package:mybend/src/features/babel/create_content_page.dart';
import 'package:mybend/src/features/bloc/local_storage_bloc.dart';
import 'package:mybend/src/model/content.dart';
import 'package:mybend/src/model/data_dto.dart';
import 'package:mybend/src/model/home_state.dart';
import 'package:mybend/src/shared/base_page.dart';
import 'package:flutter/material.dart';
import 'package:mybend/src/shared/container.dart';

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
              onPressed: () => context.pushNamed(CreateContentPage.name),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            body: BabelScreen(data: data),
          ),
        BendState() => Text(state.toString()),
      };
}

class BabelScreen extends StatefulWidget {
  const BabelScreen({super.key, required this.data});

  final DataDto data;

  @override
  State<BabelScreen> createState() => BabelScreenState();
}

class BabelScreenState extends State<BabelScreen> {
  ContentType selected = ContentType.movie;
  List<Content> list = [];

  @override
  void initState() {
    super.initState();
    list = widget.data.babel.where((e) => e.type == selected).toList();
  }

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomContainer(
                selected: selected == ContentType.book,
                child: InkWell(
                  onTap: () => setState(() {
                    selected = ContentType.book;
                    list = widget.data.babel
                        .where((e) => e.type == ContentType.book)
                        .toList();
                  }),
                  child: const Column(
                    children: [Icon(Icons.book), Text('Livre')],
                  ),
                ),
              ),
              CustomContainer(
                selected: selected == ContentType.movie,
                child: InkWell(
                  onTap: () => setState(() {
                    selected = ContentType.movie;
                    list = widget.data.babel
                        .where((e) => e.type == ContentType.movie)
                        .toList();
                  }),
                  child: const Column(
                    children: [Icon(Icons.movie), Text('Film')],
                  ),
                ),
              )
            ],
          ),
          ...list.map((e) => ContentContainer(content: e))
        ],
      );
}

class ContentContainer extends StatelessWidget {
  const ContentContainer({super.key, required this.content});
  final Content content;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () =>
          context.pushNamed(CreateContentPage.name, extra: content),
      child: CustomContainer(
        selected: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content.name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              content.comments ?? '',
              style: const TextStyle(fontSize: 12),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
