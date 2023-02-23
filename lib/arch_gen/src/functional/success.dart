import '../../arch_gen.dart';

@immutable
class Success {
  const Success();
}

@immutable
class Waiting extends Success {
  const Waiting();
}

@immutable
class Empty extends Success {
  const Empty();
}

@immutable
class StateOf<T> extends Success {
  const StateOf();
}

@immutable
class WaitingStateFor<T> extends StateOf<T> {
  const WaitingStateFor();
}

@immutable
class EmptyStateOf<T> extends StateOf<T> {
  const EmptyStateOf();
}

@immutable
class ValueStateOf<T> extends StateOf<T> {
  const ValueStateOf(this.value);

  final T value;
}
