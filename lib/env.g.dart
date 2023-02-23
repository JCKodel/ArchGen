// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnvironmentGenerator
// **************************************************************************

@immutable
class EnvProduction implements Env {
  const EnvProduction();

  IToDoRepository get toDoRepository => InMemoryToDoRepository();

  ListToDosDomain get listToDosDomain =>
      ListToDosDomain(toDoRepository: toDoRepository);
}

@immutable
class EnvDevelopment implements Env {
  const EnvDevelopment();

  IToDoRepository get toDoRepository => InMemoryToDoRepository();

  ListToDosDomain get listToDosDomain =>
      ListToDosDomain(toDoRepository: toDoRepository);
}

@immutable
class EnvTest implements Env {
  const EnvTest();

  IToDoRepository get toDoRepository => InMemoryToDoRepository();

  ListToDosDomain get listToDosDomain =>
      ListToDosDomain(toDoRepository: toDoRepository);
}
