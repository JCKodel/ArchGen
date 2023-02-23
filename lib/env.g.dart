// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnvironmentGenerator
// **************************************************************************

class EnvProduction implements Env {
  EnvProduction();

  @override
  IToDoRepository get toDoRepository => const InMemoryToDoRepository();

  ToDoListStateStore? _toDoListState;

  @override
  ToDoListStateStore get toDoListState =>
      _toDoListState ??
      (_toDoListState = ToDoListStateStore(
        listToDosDomain: listToDosDomain,
      ));

  ListToDosDomain? _listToDosDomain;

  @override
  ListToDosDomain get listToDosDomain =>
      _listToDosDomain ??
      (_listToDosDomain = ListToDosDomain(
        toDoRepository: toDoRepository,
      ));
}

class EnvDevelopment implements Env {
  EnvDevelopment();

  @override
  IToDoRepository get toDoRepository => const InMemoryToDoRepository();

  ToDoListStateStore? _toDoListState;

  @override
  ToDoListStateStore get toDoListState =>
      _toDoListState ??
      (_toDoListState = ToDoListStateStore(
        listToDosDomain: listToDosDomain,
      ));

  ListToDosDomain? _listToDosDomain;

  @override
  ListToDosDomain get listToDosDomain =>
      _listToDosDomain ??
      (_listToDosDomain = ListToDosDomain(
        toDoRepository: toDoRepository,
      ));
}

class EnvTest implements Env {
  EnvTest();

  @override
  IToDoRepository get toDoRepository => const InMemoryToDoRepository();

  ToDoListStateStore? _toDoListState;

  @override
  ToDoListStateStore get toDoListState =>
      _toDoListState ??
      (_toDoListState = ToDoListStateStore(
        listToDosDomain: listToDosDomain,
      ));

  ListToDosDomain? _listToDosDomain;

  @override
  ListToDosDomain get listToDosDomain =>
      _listToDosDomain ??
      (_listToDosDomain = ListToDosDomain(
        toDoRepository: toDoRepository,
      ));
}
