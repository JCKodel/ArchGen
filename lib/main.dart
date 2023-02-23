import 'env.dart';

Future<void> main() async {
  Env.initializeEnvironment(EnvDevelopment());

  final state = Env.current.toDoListState;
  final state2 = Env.current.toDoListState;

  print(state == state2);
}
