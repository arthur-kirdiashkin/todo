import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor_test/features/auth/biometric/biometric_repository.dart';
import 'package:text_editor_test/features/auth/biometric/bloc/biometric_bloc.dart';
import 'package:text_editor_test/features/auth/data/repository/authentication_repository.dart';
import 'package:text_editor_test/features/auth/database/bloc/database_bloc.dart';
import 'package:text_editor_test/features/auth/database/database_repository.dart';
import 'package:text_editor_test/features/auth/form-validation/bloc/form_bloc.dart';
import 'package:text_editor_test/features/auth/form-validation/welcome_page.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_bloc.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_event.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_state.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_database_repository.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_repository.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/encrypt_bloc/encrypt_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_database_bloc/todo_database_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/page/todo_page.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_qrcode_bloc/todo_qrcode_bloc.dart';

import 'package:text_editor_test/firebase_options.dart';
import 'package:text_editor_test/locator.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  final FirebaseAuth auth = FirebaseAuth.instanceFor(app: app);

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
            create: (context) => locator<TodoDatabaseRepository>()),
        RepositoryProvider(
            create: (context) => locator<AuthenticationRepository>()),
        RepositoryProvider(create: (context) => locator<DatabaseRepository>()),
        RepositoryProvider(create: (context) => locator<TodoRepository>()),
        RepositoryProvider(create: (context) => locator<BiometricRepository>()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => locator<EncryptBloc>()),
          BlocProvider(create: (context) => locator<TodoQRCodeBloc>()),
          BlocProvider(
              create: (context) =>
                  locator<BiometricBloc>()..add(IsBiometricEvent())),
          BlocProvider(create: (context) => locator<TodoTitleBloc>()),
          BlocProvider(create: (context) => locator<TodoDatabaseBloc>()),
          BlocProvider(
              create: (context) => locator<TodoBloc>()..add(GetTodoEvent())),
          BlocProvider(
            create: (context) =>
                locator<AuthenticationBloc>()..add(AuthenticationStarted()),
          ),
          BlocProvider(create: (context) => locator<FormBloc>()),
          BlocProvider(create: (context) => locator<DatabaseBloc>())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: BlocListener<BiometricBloc, BiometricState>(
              listener: (context, state) {
                if (state is BiometricOn) {
                  showModalBottomSheet(
                    isDismissible: false,
                    context: context,
                    builder: (context) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: SizedBox(
                            height: 100,
                            child: Column(
                              children: [
                                const Text('Please complete biometrics to processed'),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.only(
                                          top: 12, bottom: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        side: const BorderSide(
                                            color: Colors.black),
                                      ),
                                    ),
                                    child: const Icon(Icons.fingerprint),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      context
                                          .read<BiometricBloc>()
                                          .add(IsAuthenticatedEvent());
                                      context
                                          .read<AuthenticationBloc>()
                                          .add(AuthenticationStarted());
                                    }),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationSuccess) {
                    return const TodoPage();
                  } else if (state is AuthenticationNotSuccess) {
                    return const WelcomePage();
                  } else if (state is AuthenticationFailure) {
                    return Scaffold(
                        floatingActionButton: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const WelcomePage()),
                                (route) => false);
                          },
                          child: const Text('Go to Start Page'),
                        ),
                        body: const Center(
                            child: Text('Ошибка авторизации пользователя')));
                  } else {
                    return const WelcomePage();
                  }
                },
              ),
            )),
      ),
    );
  }
}
