import '../../arch_gen.dart';

@immutable
class Uses {
  const Uses(this.environments);

  final Map<String, Iterable<Type>> environments;
}
