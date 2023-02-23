import 'arch_gen/arch_gen.dart';
import 'to_do_arch/contracts/i_to_do_repository.dart';
import 'to_do_arch/domain/list_to_dos_domain.dart';
import 'to_do_arch/repositories/in_memory_to_do_repository.dart';
import 'to_do_arch/states/to_do_list_state_store.dart';

part 'env.g.dart';

@Environment()
abstract class Env {
  static const String production = "EnvProduction";
  static const String development = "EnvDevelopment";
  static const String test = "EnvTest";

  static void initializeEnvironment(Env currentEnvironment) {
    _currentEnvironment = currentEnvironment;
  }

  static late Env _currentEnvironment;
  static Env get current => _currentEnvironment;

  IToDoRepository get toDoRepository;
  ListToDosDomain get listToDosDomain;
  ToDoListStateStore get toDoListState;
}
