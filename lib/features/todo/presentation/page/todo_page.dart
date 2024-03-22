
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:text_editor_test/features/auth/form-validation/welcome_page.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_bloc.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_state.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_qrcode_bloc/todo_qrcode_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_state.dart';
import 'package:text_editor_test/features/todo/presentation/page/item_page.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_state.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_qrcode_bloc/todo_qrcode_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_qrcode_bloc/todo_qrcode_state.dart';
import 'package:text_editor_test/features/todo/presentation/page/settings_page.dart';
import 'package:text_editor_test/features/todo/presentation/page/todo_title_page.dart';
import 'package:text_editor_test/features/todo/presentation/page/todo_title_page_windows.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final passwordController = TextEditingController();
  var hidePassword;

  @override
  void initState() {
    hidePassword = true;
    super.initState();
  }

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
        BlocListener<TodoQRCodeBloc, TodoQRCodeState>(
          listener: (context, state) {
            if (state is TodoQRCodeLoaded) {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: QrImageView(
                        data: state.todoJson,
                        size: 300,
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
                  context.read<TodoBloc>().add(GetTodoDatabaseEvent());
                },
                child: const Text('Load from Firebase')),
            appBar: AppBar(
              backgroundColor: Colors.blue,
              actions: <Widget>[
                qrCodeButton(context)!,
                addButton(context)!,
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    )),
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
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TodoLoaded) {
                    if (state.todo.isEmpty || state.todo == null) {
                      return  centerTitle()!;
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.todo.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onLongPress: () {
                            context.read<TodoQRCodeBloc>().add(
                                TodoAddQRCodeEvent(todo: state.todo[index]));
                          },
                          onTap: () {
                            context
                                .read<TodoTitleBloc>()
                                .add(AddOneTodoEvent(todo: state.todo[index]));

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => selectTodoTitlePage()!));
                          },
                          child: Card(
                            color: const Color.fromARGB(255, 255, 225, 222),
                            child: ListTile(
                              trailing: deleteIcon(context, state.todo, index),
                              title: Text(state.todo[index].title!),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
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
                .push(MaterialPageRoute(builder: (context) => const ItemPage()));
          });
    } else if (Platform.isAndroid) {
      return const SizedBox.shrink();
    }
  }

  Widget? deleteIcon(BuildContext context, todo, int index) {
    if (kIsWeb) {
      return InkWell(
          child: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onTap: () {
            context.read<TodoBloc>().add(DeleteTodoEvent(
                id: todo[index].id, todoTitle: todo[index].title!));
          });
    } else if (Platform.isAndroid) {
      return const SizedBox.shrink();
    }
  }

  Widget? selectTodoTitlePage() {
    if (kIsWeb) {
      return TodoTitlePageWindows();
    } else if (Platform.isAndroid) {
      return TodoTitlePage();
    }
  }

  Widget? qrCodeButton(BuildContext context) {
    if (kIsWeb) {
      return const SizedBox.shrink();
    } else if (Platform.isAndroid) {
      return IconButton(
          color: Colors.black,
          onPressed: () {
            context.read<TodoTitleBloc>().add(GetTitleFromQRCodeEvent());
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoTitlePage(),
                ));
          },
          icon: const Icon(
            Icons.qr_code,
            color: Colors.white,
          ));
    }
  }

  Widget? centerTitle() {
    if(kIsWeb) {
      return Center(
                        child: Text('Press "+" to add item'),
                      );
    } else if(Platform.isAndroid) {
      return Center(
        child: Text('No items'),
      );
    }
  }
}
