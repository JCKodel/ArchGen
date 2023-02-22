import 'dart:convert';

import 'features/entities/i_to_do_entity.dart';

void main() {
  final now = DateTime.now();

  final todo = ToDoEntity(
    description: "Descrição",
    completed: false,
    creationTime: now,
    priority: ToDoPriority.high,
  );

  final todo2 = ToDoEntity(
    completed: true,
    creationTime: now,
    description: "Nested",
    priority: ToDoPriority.low,
    child: todo,
    deletedTime: DateTime.now(),
    id: 4,
    oldPriority: ToDoPriority.high,
  );

  print(todo2);

  final todo4 = todo2.copyWith(completed: true);
  final j = jsonEncode(todo2.toMap());

  print(todo2 == todo4);
  print(j);
  print(todo4 == ToDoEntity.fromMap(jsonDecode(j) as Map<String, Object?>));

  final json = jsonEncode(todo.toMap());

  print(json);

  final todo3 = ToDoEntity.fromMap(jsonDecode(json) as Map<String, Object?>);

  print(todo);
  print(todo3);
  print(todo == todo3);
}
