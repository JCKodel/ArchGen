// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_to_do_entity.dart';

// **************************************************************************
// EntityGenerator
// **************************************************************************

@immutable
class ToDoEntity implements IToDoEntity, IEquatable, ICopyable, ISerializable {
  const ToDoEntity({
    required this.description,
    required this.completed,
    required this.creationTime,
    required this.priority,
    this.deletedTime,
    this.id,
    this.oldPriority,
    this.child,
  });

  final String description;
  final bool completed;
  final DateTime creationTime;
  final ToDoPriority priority;
  final DateTime? deletedTime;
  final int? id;
  final ToDoPriority? oldPriority;
  final IToDoEntity? child;

  @override
  String toString() {
    return 'IToDoEntity(\n'
        '  child: ${child}\n'
        '  completed: ${completed}\n'
        '  creationTime: ${creationTime}\n'
        '  deletedTime: ${deletedTime}\n'
        '  description: ${description}\n'
        '  id: ${id}\n'
        '  oldPriority: ${oldPriority}\n'
        '  priority: ${priority}\n'
        ')';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is ToDoEntity) {
      return other.runtimeType == runtimeType &&
          other.child == child &&
          other.completed == completed &&
          other.creationTime == creationTime &&
          other.deletedTime == deletedTime &&
          other.description == description &&
          other.id == id &&
          other.oldPriority == oldPriority &&
          other.priority == priority;
    }

    return false;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      child,
      completed,
      creationTime,
      deletedTime,
      description,
      id,
      oldPriority,
      priority,
    );
  }

  ToDoEntity copyWith({
    IToDoEntity? child,
    bool? completed,
    DateTime? creationTime,
    DateTime? deletedTime,
    String? description,
    int? id,
    ToDoPriority? oldPriority,
    ToDoPriority? priority,
  }) {
    return ToDoEntity(
      child: child ?? this.child,
      completed: completed ?? this.completed,
      creationTime: creationTime ?? this.creationTime,
      deletedTime: deletedTime ?? this.deletedTime,
      description: description ?? this.description,
      id: id ?? this.id,
      oldPriority: oldPriority ?? this.oldPriority,
      priority: priority ?? this.priority,
    );
  }

// ignore: sort_constructors_first
  factory ToDoEntity.fromMap(Map<String, Object?> map) {
    return ToDoEntity(
        child: map['child'] == null
            ? null
            : ToDoEntity.fromMap(map['child'] as Map<String, Object?>),
        completed: map['completed'] as bool,
        creationTime: DateTime.parse(map['creationTime'] as String).toLocal(),
        deletedTime: map['deletedTime'] == null
            ? null
            : DateTime.parse(map['deletedTime'] as String).toLocal(),
        description: map['description'] as String,
        id: map['id'] as int?,
        oldPriority: map['oldPriority'] == null
            ? null
            : {
                'high': ToDoPriority.high,
                'normal': ToDoPriority.normal,
                'low': ToDoPriority.low,
              }[map['oldPriority'] as String],
        priority: {
          'high': ToDoPriority.high,
          'normal': ToDoPriority.normal,
          'low': ToDoPriority.low,
        }[map['priority'] as String]!);
  }

  @override
  Map<String, Object?> toMap() {
    return <String, Object?>{
      'child': child?.toMap(),
      'completed': completed,
      'creationTime': creationTime.toUtc().toIso8601String(),
      'deletedTime': deletedTime?.toUtc().toIso8601String(),
      'description': description,
      'id': id,
      'oldPriority': oldPriority?.toString().substring(13),
      'priority': priority.toString().substring(13),
    };
  }
}
