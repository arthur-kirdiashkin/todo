import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_add_bloc/todo_add_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_add_bloc/todo_add_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_database_bloc/todo_database_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_database_bloc/todo_database_event.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    final wordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: wordController,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(255, 255, 232, 240),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 10,
                      color: Color.fromARGB(255, 108, 189, 255),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
                ),
                onPressed: () {
                  context
                      .read<TodoBloc>()
                      .add(AddTodoEvent(todoTitle: wordController.text));
                      // context.read<TodoBloc>().add(AddTodoDatabaseEvent(todoTitle: wordController.text));
                  // context.read<TodoDatabaseBloc>().add(
                  //     AddTodoDatabaseEvent(textTitle: wordController.text));
                  wordController.clear();
                },
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Ок',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
