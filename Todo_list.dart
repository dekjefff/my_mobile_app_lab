import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => TodoListPageState();
}

class TodoListPageState extends State<TodoListPage> {
  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Do Assignmant', 'isDone': false},
  ];

 
  void addNewTask() {
    setState(() {
      _tasks.add({'title': 'My Task is here', 'isDone': false});
    });
  }

  void _editTask(int index) {
    TextEditingController _editController = TextEditingController(
      text: _tasks[index]['title'],
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Task Name"),
          content: TextField(
            controller: _editController,
            autofocus: true,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                setState(() => _tasks[index]['title'] = _editController.text);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Jeffrey ToDo List',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: CheckboxListTile(
                  value: _tasks[index]['isDone'],
                  onChanged: (bool? value) {
                    setState(() {
                      _tasks[index]['isDone'] = value ?? false;
                    });
                  },
                  title: InkWell(
                    onTap: () => _editTask(index),
                    child: Text(
                      _tasks[index]['title'],
                      style: TextStyle(
                        decoration: _tasks[index]['isDone'] ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}