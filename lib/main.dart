import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:text_editor_test/features/auth/biometric/biometric_repository.dart';
import 'package:text_editor_test/features/auth/biometric/bloc/biometric_bloc.dart';
import 'package:text_editor_test/features/auth/data/repository/authentication_repository.dart';
import 'package:text_editor_test/features/auth/database/bloc/database_bloc.dart';
import 'package:text_editor_test/features/auth/database/database_repository.dart';
import 'package:text_editor_test/features/auth/form-validation/bloc/form_bloc.dart';
import 'package:text_editor_test/features/auth/form-validation/sign_up_page.dart';
import 'package:text_editor_test/features/auth/form-validation/welcome_page.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_bloc.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_event.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_state.dart';
import 'package:text_editor_test/features/auth/presentation/page/sign_in_page.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_database_repository.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_repository.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_database_bloc/todo_database_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/page/todo_page.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_qrcode_bloc/todo_qrcode_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_qrcode_bloc/todo_qrcode_event.dart';
import 'package:text_editor_test/firebase_options.dart';
import 'package:text_editor_test/locator.dart';
import 'package:text_editor_test/utils/constants.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  final FirebaseAuth auth = FirebaseAuth.instanceFor(app: app);

  // await auth.useAuthEmulator('localhost', 9099);

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
            create: (context) => locator<TodoDatabaseRepository>()),
        RepositoryProvider(
            create: (context) => locator<AuthenticationRepository>()),
        RepositoryProvider(create: (context) => locator<DatabaseRepository>()),
        RepositoryProvider(create: (context) => locator<TodoRepository>()),
        RepositoryProvider(create: (context) => locator<BiometricRepository>()),
      ],
      child: MultiBlocProvider(
        providers: [
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
                            Text('Please complete biometrics to processed'),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.only(top: 12, bottom: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: const BorderSide(color: Colors.black),
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
            // else if(state is BiometricOff) {
            //     return SignInPage();
            // }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationSuccess) {
                return const TodoPage();
              } else if (state is AuthenticationNotSuccess) {
                return WelcomePage();
              } else if (state is AuthenticationFailure) {
                return Scaffold(
                    floatingActionButton: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => WelcomePage()),
                            (route) => false);
                      },
                      child: Text('Go to Start Page'),
                    ),
                    body:
                        Center(child: Text('Ошибка авторизации пользователя')));
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
