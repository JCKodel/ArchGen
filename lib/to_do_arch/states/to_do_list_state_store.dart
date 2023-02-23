import '../../arch_gen/arch_gen.dart';
import '../../env.dart';
import '../domain/list_to_dos_domain.dart';
import '../entities/i_to_do_entity.dart';

@UseThisConcreteOn(Env.development)
@UseThisConcreteOn(Env.production)
@UseThisConcreteOn(Env.test)
class ToDoListStateStore extends StateStore<Iterable<IToDoEntity>> {
  ToDoListStateStore({required ListToDosDomain listToDosDomain}) : _listToDosDomain = listToDosDomain;

  final ListToDosDomain _listToDosDomain;

  @override
  void onInitialize() {
    emitStateAsync(() => _listToDosDomain.getToDos(ListToDosFilter.all));
  }

  void changeListFilter(ListToDosFilter filter) {
    emitStateAsync(() => _listToDosDomain.getToDos(filter));
  }
}
