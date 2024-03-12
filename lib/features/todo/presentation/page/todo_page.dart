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
import 'package:text_editor_test/features/todo/presentation/page/item_page.dart';
import 'package:text_editor_test/features/todo/presentation/todo_bloc/todo_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/todo_bloc/todo_state.dart';
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
              onPressed: () {}, child: Text('Load from Firebase')),
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
          body: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
               List<Todo> todo = [];
              if (state is TodoLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TodoLoaded) {
                todo.add(state.todo);
                return ListView.builder(
                  itemCount: todo.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(title: Text(state.todo.title)),
                    );
                  },
                );
              }
              return SizedBox.shrink();
            },
          ),
          // body: BlocBuilder<DatabaseBloc, DatabaseState>(
          //   builder: (context, state) {
          //     String? displayName = (context.read<AuthenticationBloc>().state
          //             as AuthenticationSuccess)
          //         .displayName;
          //     if (state is DatabaseSuccess &&
          //         displayName !=
          //             (context.read<DatabaseBloc>().state as DatabaseSuccess)
          //                 .displayName) {
          //       context.read<DatabaseBloc>().add(DatabaseFetched(displayName));
          //     }
          //     if (state is DatabaseInitial) {
          //       context.read<DatabaseBloc>().add(DatabaseFetched(displayName));
          //       return const Center(child: CircularProgressIndicator());
          //     } else if (state is DatabaseSuccess) {
          //       if (state.listOfUserData.isEmpty) {
          //         return const Center(
          //           child: Text(Constants.textNoData),
          //         );
          //       } else {
          // return Center(
          //   child: ListView.builder(
          //     itemCount: state.listOfUserData.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Card(
          //         child: ListTile(
          //           title:
          //               Text(state.listOfUserData[index].displayName!),
          //           subtitle: Text(state.listOfUserData[index].email!),
          //         ),
          //       );
          //     },
          //   ),
          // );
          //       }
          //     } else {
          //       return const Center(child: CircularProgressIndicator());
          //     }
          //   },
          // ),
        );
      },
    );
  }
}


