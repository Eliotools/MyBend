import 'package:mybend/core/data/repositories/babel_repository.dart';
import 'package:mybend/features/babel/models/content.dart';

class UpdateBabelContentUseCase {
  UpdateBabelContentUseCase(this._babelRepository);

  final BabelRepository _babelRepository;

  Future<void> call(Content content) async =>
      _babelRepository.updateBabelContent(content);
}
