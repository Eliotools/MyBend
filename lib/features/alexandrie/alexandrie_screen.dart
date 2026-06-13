import 'package:flutter/material.dart';
import 'package:mybend/core/themes/app_theme.dart';
import 'package:mybend/features/alexandrie/models/alexandrie_category.dart';
import 'package:mybend/features/alexandrie/models/alexandrie_item.dart';
import 'package:mybend/features/alexandrie/alexandrie_cubit.dart';
import 'package:mybend/shared/cubit_screen.dart';
import 'package:mybend/shared/ui/selector.dart';
import 'package:mybend/src/shared/data_state.dart';
import 'package:mybend/features/alexandrie/alexandrie_add_modal.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlexandrieScreen extends CubitScreen<AlexandrieCubit, DataState> {
  const AlexandrieScreen({super.key});

  @override
  String get name => 'Alexandrie';

  @override
  void Function(AlexandrieCubit cubit)? get onInit => (cubit) => cubit.load();

  @override
  Widget Function(BuildContext context, DataState state)?
      get floatingActionButton =>
          (context, state) => state is Loaded<AlexandrieLoadDto>
              ? Builder(
                  builder: (context) => FloatingActionButton(
                    onPressed: () => showModalBottomSheet<AlexandrieItem?>(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) =>
                          AlexandrieAddModal(categories: state.data.categories),
                    ).then((value) =>
                        value != null ? cubit.createAlexandrie(value) : null),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                )
              : const SizedBox.shrink();

  @override
  Widget buildPage(BuildContext context, DataState state) => switch (state) {
        Initial() || Loading() => const Center(
            child: CircularProgressIndicator(),
          ),
        Error(message: final message) => Center(
            child: Text(message, style: AppTheme.textTheme.bodyMedium),
          ),
        Loaded<AlexandrieLoadDto>(data: final data) => AlexandrieContent(
            alexandries: data.alexandries,
            categories: data.categories,
          ),
        _ => const SizedBox.shrink(),
      };
}

//TODO(refactor): move to separate file
class AlexandrieContent extends StatefulWidget {
  const AlexandrieContent(
      {super.key, required this.alexandries, required this.categories});

  final List<AlexandrieItem> alexandries;
  final List<AlexandrieCategory> categories;

  @override
  State<AlexandrieContent> createState() => _AlexandrieContentState();
}

class _AlexandrieContentState extends State<AlexandrieContent> {
  String? selectedCategory;
  List<AlexandrieItem> filteredAlexandries = [];

  @override
  void initState() {
    super.initState();
    filteredAlexandries = widget.alexandries;
  }

  @override
  Widget build(BuildContext context) =>
      ListView(scrollDirection: Axis.vertical, children: [
        widget.categories.isNotEmpty
            ? Selector(
                selectedItem: selectedCategory ?? '*',
                items:
                    widget.categories.map((category) => category.name).toList(),
                onSelected: (value) => setState(() {
                      selectedCategory = value;
                      if (value == '*') {
                        filteredAlexandries = widget.alexandries;
                      } else {
                        final valueId = widget.categories
                            .firstWhere((category) => category.name == value)
                            .id;
                        filteredAlexandries = widget.alexandries
                            .where((alexandrie) =>
                                alexandrie.categoryId == valueId)
                            .toList();
                      }
                    }),
                onAdd: (value) => context
                    .read<AlexandrieCubit>()
                    .createCategory(AlexandrieCategory(name: value)))
            : const Text('No categories'),
        const Gap(16),
        ...filteredAlexandries.map((alexandrie) => Text('uiii'))
      ]);
}
