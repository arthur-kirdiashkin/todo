import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_repository.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_qrcode_bloc/todo_qrcode_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_qrcode_bloc/todo_qrcode_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_qrcode_bloc/todo_qrcode_state.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_state.dart';
import 'dart:io' show Platform;

import 'package:text_editor_test/features/todo/presentation/page/todo_title_page.dart';

class TodoTitlePageWindows extends StatefulWidget {
  TodoTitlePageWindows({
    super.key,
  });

  @override
  State<TodoTitlePageWindows> createState() => _TodoTitlePageWindowsState();
}

class _TodoTitlePageWindowsState extends State<TodoTitlePageWindows> {
  final titleController = TextEditingController();
  final subTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoQRCodeBloc, TodoQRCodeState>(
      listener: (context, state) {
        if (state is TodoQRCodeLoaded) {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: QrImageView(
                    data: state.todoJson,
                    size: 400,
                  ),
                ),
              );
            },
          );
        }
      },
      child: BlocBuilder<TodoTitleBloc, TodoTitleState>(
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
              floatingActionButton: ElevatedButton(
                style: ButtonStyle(),
                onPressed: () {
                  context.read<TodoTitleBloc>().add(UpdateTodoSubTitleEvent(
                        todo: state.todo,
                        subTitle: subTitleController.text,
                      ));
                  context.read<TodoBloc>().add(GetTodoEvent());
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Ok and Save',
                  style: TextStyle(fontSize: 25),
                ),
              ),
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
                        controller: titleController..text = state.todo.title!,
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
                          controller: state.todo.subTitle == '' ||
                                  state.todo.subTitle == null
                              ? subTitleController
                              : (subTitleController
                                ..text = state.todo.subTitle!),
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
                      ElevatedButton(
                          onPressed: () {
                            // context.read<TodoTitleBloc>().add(AddQRCodeEvent(
                            //     todoJson: jsonEncode(state.todo.toMap())));
                            context
                                .read<TodoQRCodeBloc>()
                                .add(TodoAddQRCodeSubtitleEvent(
                                  todo: state.todo,
                                  subtitile: subTitleController.text,
                                ));
                          },
                          child: Text('Create QR Code')),
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
              floatingActionButton: ElevatedButton(
                style: ButtonStyle(),
                onPressed: () {
                  context.read<TodoTitleBloc>().add(UpdateTodoSubTitleEvent(
                        todo: state.todo,
                        subTitle: subTitleController.text,
                      ));
                  context.read<TodoBloc>().add(GetTodoEvent());
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Ok and Save',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              appBar: AppBar(
                title: Text(state.todo.title!),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        context.read<TodoTitleBloc>().add(UpdateTodoTitleEvent(
                              todo: state.todo,
                              title: value,
                            ));
                      },
                      controller: titleController..text = state.todo.title!,
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
                    ElevatedButton(
                        onPressed: () {
                          context
                              .read<TodoQRCodeBloc>()
                              .add(TodoAddQRCodeSubtitleEvent(
                                todo: state.todo,
                                subtitile: subTitleController.text,
                              ));
                          // context
                          //     .read<TodoTitleBloc>()
                          //     .add(AddQRCodeSubtitleEvent(
                          //       todo: state.todo,
                          //       subtitile: subTitleController.text,
                          //     ));
                          // context.read<TodoTitleBloc>().add(AddQRCodeEvent(
                          //     todoJson: jsonEncode(state.todo.toMap())));
                        },
                        child: Text('Create QR Code')),
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
      ),
    );
  }
}
