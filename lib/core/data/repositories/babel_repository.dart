import 'package:mybend/features/babel/models/content.dart';
import 'package:mybend/core/data/datasources/babel_datasource.dart';

abstract class BabelRepository {
  Future<List<Content>> getBabelContents();
  Future<void> addBabelContent(Content content);
  Future<void> updateBabelContent(Content content);
  Future<void> deleteBabelContent(Content content);
}

class BabelRepositoryImpl implements BabelRepository {
  final BabelDataSource babelDataSource;
  BabelRepositoryImpl(this.babelDataSource);

  @override
  Future<List<Content>> getBabelContents() async =>
      await babelDataSource.getBabelContents();

  @override
  Future<void> addBabelContent(Content content) async =>
      await babelDataSource.addBabelContent(content);

  @override
  Future<void> updateBabelContent(Content content) async =>
      await babelDataSource.updateBabelContent(content);

  @override
  Future<void> deleteBabelContent(Content content) async =>
      await babelDataSource.deleteBabelContent(content);
}
