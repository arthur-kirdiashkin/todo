import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:text_editor_test/features/auth/biometric/bloc/biometric_bloc.dart';
import 'package:text_editor_test/features/auth/database/bloc/database_bloc.dart';
import 'package:text_editor_test/features/auth/form-validation/welcome_page.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_bloc.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_event.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_state.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_database_bloc/todo_database_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_database_bloc/todo_database_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_database_bloc/todo_database_state.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_state.dart';
import 'package:text_editor_test/features/todo/presentation/page/item_page.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_add_bloc/todo_add_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_add_bloc/todo_add_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_add_bloc/todo_add_state.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_get_bloc/todo_get_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_get_bloc/todo_get_state.dart';
import 'package:text_editor_test/features/todo/presentation/page/todo_title_page.dart';
import 'package:text_editor_test/features/todo/presentation/page/todo_title_page_windows.dart';
import 'package:text_editor_test/utils/constants.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationFailure) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                  (Route<dynamic> route) => false);
            }
          },
        ),
        BlocListener<TodoTitleBloc, TodoTitleState>(
          listener: (context, state) {
            if (state is QRCodeTodoTitleLoaded) {
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
        ),
      ],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: ElevatedButton(
                onPressed: () {
                  // context.read<TodoDatabaseBloc>().add(LoadTodoDataEvent());
                  context.read<TodoBloc>().add(GetTodoDatabaseEvent());
                },
                child: Text('Load from Firebase')),
            appBar: AppBar(
              backgroundColor: Colors.blue,
              actions: <Widget>[
                qrCodeButton(context)!,
                addButton(context)!,
                IconButton(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      context
                          .read<AuthenticationBloc>()
                          .add(AuthenticationSignedOut());
                    })
              ],
              title: Text((state as AuthenticationSuccess).displayName!),
            ),
            body: MultiBlocListener(
              listeners: [
                BlocListener<TodoBloc, TodoState>(
                  listener: (context, state) {},
                ),
                BlocListener<TodoTitleBloc, TodoTitleState>(
                  listener: (BuildContext context, TodoTitleState state) {
                    if (state is TodoTitleUpdated) {
                      state.todo;
                    }
                  },
                )
              ],
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodoLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TodoLoaded) {
                    if (state.todo.isEmpty) {
                      return Center(
                        child: Text('Press "+" to add item'),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.todo.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onLongPress: () {
                            context.read<TodoTitleBloc>().add(AddQRCodeEvent(
                                todoJson:
                                    jsonEncode(state.todo[index].toMap())));
                          },
                          onTap: () {
                            context
                                .read<TodoTitleBloc>()
                                .add(AddOneTodoEvent(todo: state.todo[index]));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => selectTodoTitlePage()!,
                                ));
                          },
                          child: Card(
                            color: Color.fromARGB(255, 255, 225, 222),
                            child: ListTile(
                              trailing: deleteIcon(context, state.todo, index),
                              title: Text(state.todo[index].title!),
                              // leading: qrCodeButton(context, state.todo[index]),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget? addButton(BuildContext context) {
    if (kIsWeb) {
      return IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ItemPage()));
          });
    } else if (Platform.isAndroid) {
      return SizedBox.shrink();
    }
  }

  Widget? deleteIcon(BuildContext context, todo, int index) {
    if (kIsWeb) {
      return InkWell(
          child: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onTap: () {
            context.read<TodoBloc>().add(DeleteTodoEvent(
                id: todo[index].id, todoTitle: todo[index].title!));
          });
    } else if (Platform.isAndroid) {
      return SizedBox.shrink();
    }
  }

  Widget? selectTodoTitlePage() {
    if (kIsWeb) {
      return TodoTitlePageWindows();
    } else if (Platform.isAndroid) {
      return TodoTitlePage();
    }
  }

  Widget? qrCodeButton(
    BuildContext context,
  ) {
    if (kIsWeb) {
      return SizedBox.shrink();
    } else if (Platform.isAndroid) {
      return IconButton(
          color: Colors.black,
          onPressed: () {
            context.read<TodoTitleBloc>().add(GetTitleFromQRCodeEvent());
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => selectTodoTitlePage()!,
                ));
          },
          icon: Icon(
            Icons.qr_code,
            color: Colors.white,
          ));
    }
  }
}
