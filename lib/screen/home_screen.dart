import 'package:flutter/material.dart';
import 'package:rest_api/controllers/todo_controller.dart';
import 'package:rest_api/models/Todo.dart';
import 'package:rest_api/repository/todo_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    var todoController = TodoController(TodoRepository());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[100],
        title: Text('REST API'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoController.fetchTodoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('error'),
            );
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              var todo = snapshot.data?[index];
              return Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Text('${todo?.id}')),
                    Expanded(flex: 2, child: Text('${todo?.title}')),
                    Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                                onTap: () {
                                  todoController
                                      .updatePatchCompleted(todo!)
                                      .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        content: Text('$value'),
                                      ),
                                    );
                                  });
                                },
                                child: buildCallContainer(
                                    "patch", Color(0xffffe0b2))),
                            InkWell(
                                onTap: () {
                                  todoController
                                      .updatePutCompleted(todo!)
                                      .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        content: Text('$value'),
                                      ),
                                    );
                                  });
                                },
                                child: buildCallContainer(
                                    "put", Color(0xffe1bee7))),
                            InkWell(
                                onTap: () {
                                  todoController
                                      .deleteTodo(todo!)
                                      .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        content: Text('$value'),
                                      ),
                                    );
                                  });
                                },
                                child: buildCallContainer(
                                    "del", Color(0xffffcdd2))),
                          ],
                        )),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 0.5,
                height: 0.5,
              );
            },
            itemCount: snapshot.data?.length ?? 0,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Todo todo = Todo(userID: 3, title: "test todo", completed: false);
          todoController.addTodo(todo).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(milliseconds: 500),
                content: Text('$value'),
              ),
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Container buildCallContainer(String title, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Center(child: Text('$title')),
    );
  }
}
