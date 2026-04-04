class Todo {
  final String id;
  final String title;
  final bool isDone;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  Todo copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      isDone: json['isDone'] as bool? ?? false,
    );
  }
}