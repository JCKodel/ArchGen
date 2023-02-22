import '../../arch_gen/arch_gen.dart';
import '../entities/i_to_do_entity.dart';

@immutable
abstract class IToDoRepository {
  ///
  Future<Iterable<IToDoEntity>> listAllToDos();

  ///
  Future<Iterable<IToDoEntity>> listCompletedToDos();

  ///
  Future<Iterable<IToDoEntity>> listUncompletedToDos();

  ///
  Future<IToDoEntity> createNewToDo(IToDoEntity newToDo);

  ///
  Future<IToDoEntity> updateToDo(IToDoEntity updatedToDo);

  ///
  Future<bool> deleteToDo(int toDoId);
}
