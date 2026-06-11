import 'package:mybend/core/data/repositories/babel_repository.dart';
import 'package:mybend/features/babel/models/content.dart';

class GetBabelContentsUseCase {
  GetBabelContentsUseCase(this._babelRepository);

  final BabelRepository _babelRepository;

  Future<List<Content>> call() async => _babelRepository.getBabelContents();
}
