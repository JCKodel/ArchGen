import '../../arch_gen/arch_gen.dart';
import '../entities/i_to_do_entity.dart';

@immutable
abstract class IToDoRepository {
  ///
  Future<Either<Failure, StateOf<Iterable<ToDoEntity>>>> listAllToDos();

  ///
  Future<Either<Failure, StateOf<Iterable<ToDoEntity>>>> listCompletedToDos();

  ///
  Future<Either<Failure, StateOf<Iterable<ToDoEntity>>>> listUncompletedToDos();

  ///
  Future<Either<Failure, StateOf<ToDoEntity>>> createNewToDo(ToDoEntity newToDo);

  ///
  Future<Either<Failure, Success>> updateToDo(ToDoEntity updatedToDo);

  ///
  Future<Either<Failure, Success>> deleteToDo(int toDoId);
}
