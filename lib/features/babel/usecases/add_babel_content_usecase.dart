import 'package:mybend/core/data/repositories/babel_repository.dart';
import 'package:mybend/features/babel/models/content.dart';

class AddBabelContentUseCase {
  AddBabelContentUseCase(this._babelRepository);

  final BabelRepository _babelRepository;

  Future<void> call(Content content) async =>
    //TODO(security): check content values here and pass map<string, object> instead of content

      _babelRepository.addBabelContent(content);
}
