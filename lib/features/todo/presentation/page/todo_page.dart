import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
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
import 'package:text_editor_test/utils/constants.dart';
import 'dart:io' show Platform;

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const WelcomePage()),
              (Route<dynamic> route) => false);
        }
      },
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
                        onTap: () {
                          context
                              .read<TodoTitleBloc>()
                              .add(AddOneTodoEvent(todo: state.todo[index]));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TodoTitlePage()));
                        },
                        child: Card(
                          color: Color.fromARGB(255, 255, 225, 222),
                          child: ListTile(
                            trailing: deleteIcon(context, state.todo, index),
                            // trailing: InkWell(
                            //     child: Icon(
                            //       Icons.delete,
                            //       color: Colors.red,
                            //     ),
                            //     onTap: () {
                            //       context.read<TodoBloc>().add(DeleteTodoEvent(
                            //           id: state.todo[index].id,
                            //           todoTitle: state.todo[index].title!));
                            //     }),
                            title: Text(state.todo[index].title!),
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
    );
  }

  Widget? addButton(context) {
    if (Platform.isAndroid) {
      return SizedBox.shrink();
    } else if (Platform.isWindows) {
      return IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ItemPage()));
          });
    }
  }

  Widget? deleteIcon(BuildContext context,  todo, int index) {
    if (Platform.isAndroid) {
      return SizedBox.shrink();
    } else if (Platform.isWindows) {
      return InkWell(
          child: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onTap: () {
            context.read<TodoBloc>().add(DeleteTodoEvent(
                id: todo[index].id, todoTitle: todo[index].title!));
          });
    }
  }
}
