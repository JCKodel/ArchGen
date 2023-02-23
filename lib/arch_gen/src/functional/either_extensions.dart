import '../../arch_gen.dart';

extension Matching<L, R> on Either<L, R> {
  Either<L, R> on(bool Function(R r) predicate, L Function(R r) value) => flatMap((r) => predicate(r) ? left<L, R>(value(r)) : right<L, R>(r));
  Either<L, R> when<T extends R>(L Function(T r) value) => flatMap((r) => r is T ? left<L, R>(value(r)) : right<L, R>(r));
  L otherwise(L Function(R r) transformation) => fold(id, transformation);
}

Either<Result, A> match<Result, A>(A a) => right(a);
