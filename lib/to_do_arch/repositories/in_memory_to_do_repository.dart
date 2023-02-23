import '../../arch_gen/arch_gen.dart';
import '../../env.dart';
import '../contracts/i_to_do_repository.dart';
import '../entities/i_to_do_entity.dart';

@immutable
@ImplementedOn(Env.development)
@ImplementedOn(Env.production)
@ImplementedOn(Env.test)
class InMemoryToDoRepository implements IToDoRepository {
  const InMemoryToDoRepository();

  static final Map<int, ToDoEntity> _data = {};

  @override
  Future<Either<Failure, StateOf<ToDoEntity>>> createNewToDo(ToDoEntity newToDo) async {
    final id = _data.length + 1;

    return Right(ValueStateOf(_data[id] = newToDo.copyWith(id: id)));
  }

  @override
  Future<Either<Failure, Success>> deleteToDo(int toDoId) async {
    final exists = _data.containsKey(toDoId);

    if (exists) {
      _data.remove(toDoId);

      return const Right(Success());
    }

    return Left(ExceptionFailure(Exception("Could not delete To Do with id ${toDoId} because it doesn't exists")));
  }

  @override
  Future<Either<Failure, StateOf<Iterable<ToDoEntity>>>> listAllToDos() async {
    return Right(ValueStateOf(_data.values));
  }

  @override
  Future<Either<Failure, StateOf<Iterable<ToDoEntity>>>> listCompletedToDos() async {
    return Right(ValueStateOf(_data.values.where((e) => e.completed)));
  }

  @override
  Future<Either<Failure, StateOf<Iterable<ToDoEntity>>>> listUncompletedToDos() async {
    return Right(ValueStateOf(_data.values.where((e) => e.completed == false)));
  }

  @override
  Future<Either<Failure, Success>> updateToDo(ToDoEntity updatedToDo) async {
    if (updatedToDo.id == null) {
      return Left(ExceptionFailure(Exception("You cannot update a To Do without an id")));
    }

    final exists = _data.containsKey(updatedToDo.id);

    if (exists) {
      _data[updatedToDo.id!] = updatedToDo;
    }

    return const Right(Success());
  }
}
