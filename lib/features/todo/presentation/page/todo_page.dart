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
            actions: <Widget>[
              IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ItemPage()));
                  }),
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
          // body: ValueListenableBuilder(
          //   valueListenable: Hive.box<Todo>('HiveTodos').listenable(),
          //   builder: (BuildContext context, Box<Todo> box, _) {
          //     if (box.values.isEmpty)
          //       return Center(
          //         child: Text("No contacts"),
          //       );
          //     return ListView.builder(
          //       itemCount: box.values.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         Todo currentTodo = box.get(index)!;
          //         return Card(
          //           child: ListTile(title: Text('${currentTodo.title}')),
          //         );
          //       },
          //     );
          //   },
          // ),
          body: MultiBlocListener(
            listeners: [
              // BlocListener<TodoBloc, TodoState>(
              //   listener: (context, state) {
              //     if (state is TodoLoaded) {
              //       todo.addAll(state.todo);
              //     }
              //   },
              // ),
              BlocListener<TodoBloc, TodoState>(
                listener: (context, state) {
                  // todo.addAll(state.todo);
                },
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
                          context.read<TodoTitleBloc>().add(AddOneTodoEvent(todo: state.todo[index]));
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => TodoTitlePage(
                          //           // updatedTodo: state.todo[index],
                          //         )));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TodoTitlePage()));
                        },
                        child: Card(
                          color: Color.fromARGB(255, 255, 225, 222),
                          child: ListTile(
                            trailing: InkWell(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  // context.read<TodoBloc>().add(
                                  //     DeleteTodoFirebaseEvent(
                                  //         id: state.todo[index].id,
                                  //         todoTitle: state.todo[index].title!));
                                  context.read<TodoBloc>().add(DeleteTodoEvent(
                                      id: state.todo[index].id,
                                      todoTitle: state.todo[index].title!));
                                }),
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
            // child: BlocBuilder<TodoDatabaseBloc, TodoDatabaseState>(
            //   builder: (context, state) {
            //     if (state is TodoDatabaseLoading) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (state is TodoDatabaseSuccess) {
            //       if (state.listOfTodo.isEmpty) {
            //         return const Center(
            //           child: Text(Constants.textNoData),
            //         );
            //       } else {
            //         return ListView.builder(
            //           shrinkWrap: true,
            //           itemCount: state.listOfTodo.length,
            //           itemBuilder: (BuildContext context, int index) {
            //             return Card(
            //               color: Color.fromARGB(255, 207, 203, 255),
            //               child: ListTile(
            //                 trailing: InkWell(
            //                     child: Icon(
            //                       Icons.delete,
            //                       color: Colors.red,
            //                     ),
            //                     onTap: () {
            //                       context.read<TodoDatabaseBloc>().add(
            //                           DeleteTotoDataEvent(
            //                               id: state.listOfTodo[index].id));
            //                     }),
            //                 title: Text(state.listOfTodo[index].textTitle!),
            //               ),
            //             );
            //           },
            //         );
            //       }
            //     } else {
            //       return SizedBox.shrink();
            //     }
            //   },
            // ),
          ),
        );
      },
    );
  }
}
