import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../arch_gen.dart';

abstract class StateStore<T> {
  StateStore() {
    _stream = _subject.stream;
    onInitialize();
  }

  final _subject = BehaviorSubject<Either<Failure, StateOf<T>>>();

  late final Stream<Either<Failure, StateOf<T>>> _stream;
  Stream<Either<Failure, StateOf<T>>> get stream => _stream;

  Either<Failure, StateOf<T>> _currentState = const Right(EmptyStateOf());
  Either<Failure, StateOf<T>> get currentState => _currentState;

  Future<Either<Failure, StateOf<T>>> Function()? _lastFutureStateOf;

  void onInitialize() {}

  void emitState(Either<Failure, StateOf<T>> stateOf) {
    if (stateOf == _currentState) {
      return;
    }

    _currentState = stateOf;
    _subject.add(stateOf);
  }

  void emitStateAsync(Future<Either<Failure, StateOf<T>>> Function() futureStateOf) {
    _lastFutureStateOf = futureStateOf;

    final waitingTimer = Timer(const Duration(milliseconds: 110), () {
      _subject.add(Right(WaitingStateFor<T>()));
    });

    try {
      futureStateOf().then((result) {
        waitingTimer.cancel();
        emitState(result);
      }).catchError((Object ex) {
        waitingTimer.cancel();
        emitState(Left(ExceptionFailure(ex)));
      });
    } catch (ex) {
      waitingTimer.cancel();
      emitState(Left(ExceptionFailure(ex)));
    }
  }

  void refresh() {
    if (_lastFutureStateOf == null) {
      return;
    }

    emitStateAsync(_lastFutureStateOf!);
  }
}
