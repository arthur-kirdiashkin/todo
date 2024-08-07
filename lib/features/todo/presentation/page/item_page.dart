
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_event.dart';


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
        title: const Text('Item Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: wordController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 255, 232, 240),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 10,
                      color: Color.fromARGB(255, 108, 189, 255),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Colors.blueAccent),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
                ),
                onPressed: () {
                  context
                      .read<TodoBloc>()
                      .add(AddTodoEvent(todoTitle: wordController.text));

                  wordController.clear();
                },
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Colors.blueAccent),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
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
