class AlexandrieItem {
  AlexandrieItem({
    this.id = -1,
    this.categoryId,
    this.question,
    this.description,
    this.answer,
    this.dueDate = 0,
    this.level = 1,
  });

  final int id;
  final int? categoryId;
  final String? question;
  final String? description;
  final String? answer;
  final int dueDate;
  final int level;

  factory AlexandrieItem.fromJson(Map<String, Object?> data) => AlexandrieItem(
        id: data['id'] != null ? int.parse(data['id'].toString()) : -1,
        categoryId: data['categoryId'] != null
            ? int.parse(data['categoryId'].toString())
            : null,
        question: data['question']?.toString(),
        description: data['description']?.toString(),
        answer: data['answer']?.toString(),
        dueDate:
            data['dueDate'] != null ? int.parse(data['dueDate'].toString()) : 0,
        level: data['level'] != null ? int.parse(data['level'].toString()) : 1,
      );

  factory AlexandrieItem.empty() => AlexandrieItem();

  AlexandrieItem copyWith({
    int? id,
    int? categoryId,
    String? question,
    String? description,
    String? answer,
    int? dueDate,
    int? level,
  }) =>
      AlexandrieItem(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        question: question ?? this.question,
        description: description ?? this.description,
        answer: answer ?? this.answer,
        dueDate: dueDate ?? this.dueDate,
        level: level ?? this.level,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'categoryId': categoryId,
        'question': question,
        'description': description,
        'answer': answer,
        'dueDate': dueDate,
        'level': level,
      };
}
