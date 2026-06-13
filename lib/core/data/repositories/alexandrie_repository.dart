import 'package:mybend/core/data/datasources/alexandrie_datasource.dart';
import 'package:mybend/features/alexandrie/models/alexandrie_item.dart';
import 'package:mybend/features/alexandrie/models/alexandrie_category.dart';

abstract class AlexandrieRepository {
  Future<List<AlexandrieItem>> getAlexItems();
  Future<AlexandrieItem> createAlexItem(AlexandrieItem item);
  Future<AlexandrieItem> updateAlexItem(AlexandrieItem item);
  Future<List<AlexandrieCategory>> getAlexCategories();
  Future<AlexandrieCategory> createAlexCategory(AlexandrieCategory category);
  Future<AlexandrieItem> setDueDate(AlexandrieItem item,
      {bool validated = false});
}

class AlexandrieRepositoryImpl implements AlexandrieRepository {
  final AlexandrieDataSource alexDataSource;
  AlexandrieRepositoryImpl(this.alexDataSource);

  @override
  Future<List<AlexandrieItem>> getAlexItems() async =>
      await alexDataSource.getAlexItems();

  @override
  Future<AlexandrieItem> createAlexItem(AlexandrieItem item) async =>
      await alexDataSource.createAlexItem(item);

  @override
  Future<AlexandrieItem> updateAlexItem(AlexandrieItem item) async =>
      await alexDataSource.updateAlexItem(item);

  @override
  Future<AlexandrieItem> setDueDate(AlexandrieItem item,
          {bool validated = false}) async =>
      await alexDataSource.setDueDate(item, validated: validated);

  @override
  Future<List<AlexandrieCategory>> getAlexCategories() async =>
      await alexDataSource.getAlexCategories();

  @override
  Future<AlexandrieCategory> createAlexCategory(
          AlexandrieCategory category) async =>
      await alexDataSource.createAlexCategory(category);
}
