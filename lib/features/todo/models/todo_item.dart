class TodoItem {
  const TodoItem({
    this.id = -1,
    this.categoryId,
    required this.name,
    this.description,
    this.validated = false,
  });

  final int id;
  final int? categoryId;
  final String name;
  final String? description;
  final bool validated;

  factory TodoItem.fromJson(Map<String, Object?> data) => TodoItem(
        id: data['id'] != null ? int.parse(data['id'].toString()) : -1,
        name: data['name']?.toString() ?? 'No name',
        description: data['description']?.toString(),
        validated: data['validated'] == true ||
            data['validated']?.toString() == 'true',
        categoryId: data['categoryId'] != null
            ? int.parse(data['categoryId'].toString())
            : -1,
      );

  TodoItem copyWith({
    int? id,
    int? categoryId,
    String? name,
    String? description,
    bool? validated,
    bool? isDone,
  }) =>
      TodoItem(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        description: description ?? this.description,
        validated: validated ?? this.validated,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'categoryId': categoryId,
        'name': name,
        'description': description ?? '',
        'validated': validated,
      };
}
