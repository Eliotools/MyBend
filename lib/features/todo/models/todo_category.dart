class TodoCategory {
  const TodoCategory({
    this.id = -1,
    required this.name,
  });

  final int id;
  final String name;

  factory TodoCategory.fromJson(Map<String, Object?> data) => TodoCategory(
        id: data['id'] != null ? int.parse(data['id'].toString()) : -1,
        name: data['name']?.toString() ?? 'No name',
      );

  TodoCategory copyWith({
    int? id,
    String? name,
  }) =>
      TodoCategory(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
      };
}
