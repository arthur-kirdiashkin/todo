import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor_test/features/auth/data/repository/authentication_repository.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_bloc.dart';
import 'package:text_editor_test/features/auth/presentation/page/sign_in.dart';
import 'package:text_editor_test/features/todo/presentation/page/todo_page.dart';
import 'package:text_editor_test/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepositoryImpl(),
      child: BlocProvider(
        create: (context) => AuthBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepositoryImpl>(context)),
        child: MaterialApp(
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return TodoPage();
              }
              return SignIn();
            },
          ),
        ),
      ),
    );
  }
}
