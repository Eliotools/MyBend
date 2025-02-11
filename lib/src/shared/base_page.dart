import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/src/features/bloc/local_storage_bloc.dart';

class BasePage<B extends BlocBase<S>, S extends Object>
    extends StatelessWidget {
  const BasePage({super.key});

  Widget onBuild(BuildContext context, S state) => Text('need somethings');

  @override
  Widget build(BuildContext context) => BlocBuilder<B, S>(
        builder: onBuild,
      );
}
