class Todo {
  final String id;
  final String title;
  final bool isDone;
  final String? imagePath;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
    this.imagePath,
  });

  Todo copyWith({String? id, String? title, bool? isDone, String? imagePath}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'isDone': isDone, 'imagePath': imagePath};
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      isDone: json['isDone'] as bool? ?? false,
      imagePath: json['imagePath'] as String?,
    );
  }
}
