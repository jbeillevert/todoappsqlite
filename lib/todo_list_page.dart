import 'package:flutter/material.dart';
import 'databaseHelper.dart';
import 'models/todo_model.dart';
import 'interface/todoList.dart';
import 'interface/bottomSheet.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late Future<List<Todo>> _todoListFuture;

  @override
  void initState() {
    super.initState();
    _todoListFuture = DatabaseHelper.instance.getAllTodos();
  }

  void _addTodo(String taskName) async {
    final newTodo = Todo(
      task: taskName,
      isCompleted: false,
    );
    await DatabaseHelper.instance.insert(newTodo);
    _refreshTodoList();
  }

  void _refreshTodoList() {
    setState(() {
      _todoListFuture = DatabaseHelper.instance.getAllTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TP todo App SQLite"),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: FutureBuilder<List<Todo>>(
        future: _todoListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return TodoListDisplay(
              todos: snapshot.data!,
              onTodoToggle: _refreshTodoList,
            );
          } else {
            return const Text('No todos found.');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await showModalBottomSheet<String>(
            context: context,
            builder: (context) => const BottomSheetPopup(),
          );
          if (newTask != null) {
            _addTodo(newTask);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
