import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_repository.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_add_bloc/todo_add_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_add_bloc/todo_add_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_state.dart';
import 'dart:io' show Platform;


class TodoTitlePage extends StatefulWidget {
  
  TodoTitlePage({
    super.key,
  });

  @override
  State<TodoTitlePage> createState() => _TodoTitlePageState();
}

class _TodoTitlePageState extends State<TodoTitlePage> {
  final titleController = TextEditingController();
  final subTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoTitleBloc, TodoTitleState>(
      builder: (context, state) {
        if (state is TodoTitleLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is TodoTitleLoaded) {
          return Scaffold(
            floatingActionButton: useButton(state.todo),
            appBar: AppBar(
              title: Text(state.todo.title!),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      enabled: isEnabled(),
                      onChanged: (value) {
                        setState(() {
                          context
                              .read<TodoTitleBloc>()
                              .add(UpdateTodoTitleEvent(
                                todo: state.todo,
                                title: value,
                              ));
                        });
                      },
                      controller: titleController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Change Title',
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
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 200,
                      child: TextFormField(
                        enabled: isEnabled(),
                        controller: state.todo.subTitle == '' ||
                                state.todo.subTitle == null
                            ? subTitleController
                            : (subTitleController..text = state.todo.subTitle!),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        textAlignVertical: TextAlignVertical.top,
                        // maxLines: 4,
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        
                        decoration: InputDecoration(
                          // isDense: true,
                          // contentPadding: EdgeInsets.symmetric(
                          //     vertical: MediaQuery.of(context).size.height * 0.3),
                          labelText: 'SubTitle',
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
                    SizedBox(
                      height: 40,
                    ),
                    // Center(
                    //   child: Text(
                    //     (state.todo.subTitle == null ||
                    //             state.todo.subTitle == '')
                    //         ? 'Add some text'
                    //         : state.todo.subTitle!,
                    //     style: TextStyle(fontSize: 20),
                    //   ),
                    // ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is TodoTitleUpdated) {
          return Scaffold(
            floatingActionButton: useButton(state.todo),
            appBar: AppBar(
              title: Text(state.todo.title!),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    enabled: isEnabled(),
                    onChanged: (value) {
                      setState(() {
                        context.read<TodoTitleBloc>().add(UpdateTodoTitleEvent(
                              todo: state.todo,
                              title: value,
                            ));
                      });
                    },
                    controller: titleController,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    textAlignVertical: TextAlignVertical.top,
                    // maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Change Title',
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
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 200,
                    child: TextFormField(
                      enabled: isEnabled(),
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      textAlignVertical: TextAlignVertical.top,
                      controller: state.todo.subTitle == '' ||
                              state.todo.subTitle == null
                          ? subTitleController
                          : (subTitleController..text = state.todo.subTitle!),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        // contentPadding: EdgeInsets.symmetric(
                        //     vertical: MediaQuery.of(context).size.height * 0.3),

                        labelText: 'SubTitle',
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
                  SizedBox(
                    height: 40,
                  ),
                  // Center(
                  //   child: Text(
                  //     state.todo.subTitle ?? 'Add some text',
                  //     style: TextStyle(fontSize: 20),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        } else if (state is TodoTitleError) {
          return Center(
            child: Text('Ошибка передачи тайтла'),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  bool? isEnabled() {
    if(Platform.isAndroid) {
      return false;
    } else if(Platform.isWindows) {
      return true;
    }
  }
  Widget? useButton(Todo todo) {
    if(Platform.isAndroid) {
      return SizedBox.shrink();
    } else if(Platform.isWindows) {
      return ElevatedButton(
              style: ButtonStyle(),
              onPressed: () {
                context.read<TodoTitleBloc>().add(UpdateTodoSubTitleEvent(
                      todo: todo,
                      subTitle: subTitleController.text,
                    ));
                context.read<TodoBloc>().add(GetTodoEvent());
                Navigator.of(context).pop();
              },
              child: Text(
                'Ok and Save',
                style: TextStyle(fontSize: 25),
              ),
            );
    }
  }
}
