import '../../arch_gen/arch_gen.dart';
import '../../env.dart';
import '../contracts/i_to_do_repository.dart';
import '../entities/i_to_do_entity.dart';

enum ListToDosFilter {
  all,
  onlyCompleted,
  onlyUncompleted,
}

@immutable
@UseThisConcreteOn(Env.development)
@UseThisConcreteOn(Env.production)
@UseThisConcreteOn(Env.test)
class ListToDosDomain extends Domain {
  const ListToDosDomain({required IToDoRepository toDoRepository}) : _toDoRepository = toDoRepository;

  final IToDoRepository _toDoRepository;

  Future<Either<Failure, StateOf<Iterable<ToDoEntity>>>> getToDos(ListToDosFilter filter) {
    switch (filter) {
      case ListToDosFilter.all:
        return _toDoRepository.listAllToDos();
      case ListToDosFilter.onlyCompleted:
        return _toDoRepository.listCompletedToDos();
      case ListToDosFilter.onlyUncompleted:
        return _toDoRepository.listUncompletedToDos();
    }
  }
}
