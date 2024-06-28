import 'dart:convert';

import 'package:rest_api/models/Todo.dart';
import 'package:rest_api/repository/repository.dart';
import 'package:http/http.dart' as http;

class TodoRepository implements Repository {
  String dataURL = 'https://jsonplaceholder.typicode.com';
  @override
  Future<String> deleteTodo(Todo todo) async{
    var uri = Uri.parse('$dataURL/todos/${todo.id}');
    var result = 'false';
    await http.delete(uri).then((value){return result = 'true';});
    return result;
  }

  @override
  Future<List<Todo>> getTodoList() async {
    List<Todo> todoList = [];
    var uri = Uri.parse('$dataURL/todos');
    var response = await http.get(uri);
    print('status code ${response.statusCode}');
    var body = json.decode(response.body);

    for (var i = 0; i < body.length; i++) {
      todoList.add(Todo.fromJson(body[i]));
    }

    return todoList;
  }

  @override
  Future<String> patchCompleted(Todo todo) async {
    var uri = Uri.parse('$dataURL/todos/${todo.id}');
    String resData = '';
    try {
      var response = await http.patch(
        uri,
        body: json.encode({
          'completed': (!todo.completed!).toString(),
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'your_token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        print(result);
        resData = result['message'] ?? 'Success';
      } else {
        resData = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      print('Exception: $e');
      resData = 'Exception: $e';
    }

    return resData;
  }

  @override
  Future<String> postTodo(Todo todo) async {
    var uri = Uri.parse('$dataURL/todos');
    var response = await http.post(
      uri,
      body: json.encode(todo.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'your_token',
      },
    );

    if (response.statusCode == 201) {
      return 'Todo added successfully';
    } else {
      return 'Error: ${response.statusCode}';
    }
  }

  @override
  Future<String> putCompleted(Todo todo) async{
    var uri = Uri.parse('$dataURL/todos/${todo.id}');
    String resData = '';
    try {
      var response = await http.put(
        uri,
        body: json.encode({
          'completed': (!todo.completed!).toString(),
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'your_token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        print(result);
        resData = result['message'] ?? 'Success';
      } else {
        resData = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      print('Exception: $e');
      resData = 'Exception: $e';
    }

    return resData;
  }
}
