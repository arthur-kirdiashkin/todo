import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:text_editor_test/features/auth/data/repository/authentication_repository.dart';
import 'package:text_editor_test/features/auth/database/bloc/database_bloc.dart';
import 'package:text_editor_test/features/auth/database/database_repository.dart';
import 'package:text_editor_test/features/auth/form-validation/bloc/form_bloc.dart';
import 'package:text_editor_test/features/auth/form-validation/welcome_page.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_bloc.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_event.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_state.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_repository.dart';
import 'package:text_editor_test/features/todo/presentation/page/todo_page.dart';
import 'package:text_editor_test/features/todo/presentation/todo_add_bloc/todo_add_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/todo_add_bloc/todo_add_event.dart';
import 'package:text_editor_test/features/todo/presentation/todo_get_bloc/todo_get_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/todo_get_bloc/todo_get_event.dart';
import 'package:text_editor_test/firebase_options.dart';
import 'package:text_editor_test/locator.dart';
import 'package:text_editor_test/utils/constants.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // final appDocument = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocument.path);
  // Hive.registerAdapter<Todo>(TodoAdapter());
  // await Hive.openBox<Todo>('HiveTodos');
  await initDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthenticationRepositoryImpl(),
        ),
        RepositoryProvider(
          create: (context) => DatabaseRepositoryImpl(),
        ),
        RepositoryProvider(create: (context) => TodoRepositoryImpl())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  TodoBloc(todoRepository: TodoRepositoryImpl())..add(GetTodoEvent())
                    ),
          // BlocProvider(
          //     create: (context) =>
          //         TodoAddBloc(todoRepository: TodoRepositoryImpl())),
          BlocProvider(
            create: (context) =>
                AuthenticationBloc(AuthenticationRepositoryImpl())
                  ..add(AuthenticationStarted()),
          ),
          BlocProvider(
            create: (context) => FormBloc(
                AuthenticationRepositoryImpl(), DatabaseRepositoryImpl()),
          ),
          BlocProvider(
            create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
          )
        ],
        // child: MaterialApp(
        //   home: StreamBuilder<User?>(
        //     stream: FirebaseAuth.instance.authStateChanges(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         return TodoPage();
        //       }
        //       return SignIn();
        //     },
        //   ),
        // ),
        child: MaterialApp(
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationSuccess) {
              return const TodoPage();
            } else {
              return const WelcomePage();
            }
          },
        )),
      ),
    );
  }
}
