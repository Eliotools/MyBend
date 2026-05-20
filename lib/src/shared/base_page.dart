import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasePage<B extends BlocBase<S>, S extends Object>
    extends StatelessWidget {
  const BasePage({super.key});

  void onInit(BuildContext context) {}

  Widget onBuild(BuildContext context, S state) =>
      const Text('need somethings');

  @override
  Widget build(BuildContext context) => BlocBuilder<B, S>(
        builder: onBuild,
      );
}
