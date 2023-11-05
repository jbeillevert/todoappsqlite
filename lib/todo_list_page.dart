import 'package:flutter/material.dart';
import 'package:todo_app_sqlite_freezed/interface/todoList.dart';
import './interface/bottomSheet.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("TP todo App sqlite"),
          centerTitle: true,
          titleTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
          backgroundColor: Colors.black54,
        ),
        body: const Center(
          child: TodoListDisplay(),
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () async {
            final newTask = await showModalBottomSheet<String>(
                context: context, builder: (context) => const BottomSheetPopup()
            );
          },
          child: const Icon(Icons.add),
        ),
      );
  }
}