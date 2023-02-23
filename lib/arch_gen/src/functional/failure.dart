import '../../arch_gen.dart';

@immutable
class Failure {
  const Failure();
}

@immutable
class ExceptionFailure extends Failure {
  const ExceptionFailure(this.exception);

  final Object exception;
}
