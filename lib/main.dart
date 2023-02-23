import 'env.dart';
import 'to_do_arch/domain/list_to_dos_domain.dart';

Future<void> main() async {
  Env.initializeEnvironment(const EnvDevelopment());

  print(await Env.current.listToDosDomain.getToDos(ListToDosFilter.all));
}
