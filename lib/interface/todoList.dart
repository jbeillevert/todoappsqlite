import 'package:flutter/material.dart';
import '../databaseHelper.dart';
import '../models/todo_model.dart';

class TodoListDisplay extends StatefulWidget {
  final List<Todo> todos; 
  final VoidCallback onTodoToggle; 

  const TodoListDisplay({
    Key? key,
    required this.todos, 
    required this.onTodoToggle, 
  }) : super(key: key);

  @override
  State<TodoListDisplay> createState() => _TodoListDisplayState();
}

class _TodoListDisplayState extends State<TodoListDisplay> {
  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: widget.todos.length,
      itemBuilder: (context, index) {
        final todo = widget.todos[index];
        return ListTile(
          title: Text(todo.task),
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (bool? newValue) {
              if (newValue != null) {
                DatabaseHelper.instance.update(todo.copyWith(isCompleted: newValue)).then((_) {
                  widget.onTodoToggle(); 
                });
              }
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              DatabaseHelper.instance.delete(todo.id!).then((_) {
                widget.onTodoToggle(); 
              });
            },
          ),
        );
      },
    );
  }
}
