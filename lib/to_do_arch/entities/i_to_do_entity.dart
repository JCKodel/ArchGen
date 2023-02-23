import '../../arch_gen/arch_gen.dart';

part 'i_to_do_entity.g.dart';

enum ToDoPriority {
  high,
  normal,
  low,
}

@immutable
@Entity()
abstract class IToDoEntity implements IEquatable, ICopyable, ISerializable {
  const factory IToDoEntity({
    required String description,
    required bool completed,
    required DateTime creationTime,
    required ToDoPriority priority,
    DateTime? deletedTime,
    int? id,
    ToDoPriority? oldPriority,
    IToDoEntity? child,
  }) = ToDoEntity;
}
