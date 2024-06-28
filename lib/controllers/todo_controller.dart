import 'package:rest_api/models/Todo.dart';
import 'package:rest_api/repository/repository.dart';

class TodoController{
  final Repository _repository;
  TodoController(this._repository);

  Future<List<Todo>> fetchTodoList() async {
    return _repository.getTodoList();
  }

  Future<String> updatePatchCompleted(Todo todo) async {
    return _repository.patchCompleted(todo);
  }

  Future<String> updatePutCompleted(Todo todo) async {
    return _repository.putCompleted(todo);
  }

  Future<String> deleteTodo(Todo todo) async {
    return _repository.deleteTodo(todo);
  }

  Future<String> addTodo(Todo todo) async {
    return _repository.postTodo(todo);
  }
}