//TODO(refactor): check to merge with TodoCategory
class AlexandrieCategory {
  const AlexandrieCategory({
    this.id = -1,
    required this.name,
  });

  final int id;
  final String name;

  factory AlexandrieCategory.fromJson(Map<String, Object?> data) =>
      AlexandrieCategory(
        id: data['id'] != null ? int.parse(data['id'].toString()) : -1,
        name: data['name']?.toString() ?? 'No name',
      );

  AlexandrieCategory copyWith({
    int? id,
    String? name,
  }) =>
      AlexandrieCategory(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
      };
}
