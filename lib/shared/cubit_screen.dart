import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

abstract class CubitScreen<TCubit extends Cubit<TState>, TState>
    extends StatelessWidget {
  const CubitScreen({super.key});

  Widget buildPage(BuildContext context, TState state);

  TCubit get cubit => getIt<TCubit>();

  final void Function(TCubit cubit)? onInit = null;


  @override
  Widget build(BuildContext context) {
    onInit?.call(cubit);
    return BlocProvider<TCubit>(
      create: (_) => cubit,
      child: BlocBuilder<TCubit, TState>(
      builder: (context, state) {
        return buildPage(context, state);
      },
    ),);
    
     
  }
}
