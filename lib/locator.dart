import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:text_editor_test/features/auth/biometric/biometric_repository.dart';
import 'package:text_editor_test/features/auth/biometric/bloc/biometric_bloc.dart';
import 'package:text_editor_test/features/auth/data/repository/authentication_repository.dart';
import 'package:text_editor_test/features/auth/database/bloc/database_bloc.dart';
import 'package:text_editor_test/features/auth/database/database_repository.dart';
import 'package:text_editor_test/features/auth/form-validation/bloc/form_bloc.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_bloc.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_list_service.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_database_repository.dart';
import 'package:text_editor_test/features/todo/data/repository/todo_repository.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_add_bloc/todo_add_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_database_bloc/todo_database_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_title_bloc/todo_title_bloc.dart';

GetIt locator = GetIt.instance;

Future<void> initDependency() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Todo>(TodoAdapter());
  Hive.registerAdapter(TodoStatusAdapter());
  Hive.registerAdapter(LocalListAdapter());
  Hive.registerAdapter(ListStatusAdapter());
  // await Hive.openBox<Todo>('HiveTodos');

  locator.registerLazySingleton<TodoDatabaseRepository>(
      () => TodoDatabaseRepositoryImpl());
  locator.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl());
  locator.registerLazySingleton<DatabaseRepository>(
      () => DatabaseRepositoryImpl());
  locator.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl());
  locator.registerLazySingleton<BiometricRepository>(() => BiometricRepositoryImpl());

  locator.registerFactory(() => TodoTitleBloc(
      todoRepository: locator<TodoRepository>(),
      todoDatabaseRepository: locator<TodoDatabaseRepository>()));
  locator.registerFactory(() => TodoDatabaseBloc(
      todoDatabaseRepository: locator<TodoDatabaseRepository>()));
  locator.registerFactory(() => TodoBloc(
      todoRepository: locator<TodoRepository>(),
      todoDatabaseRepository: locator<TodoDatabaseRepository>()));
  locator.registerFactory(() => AuthenticationBloc(
      authenticationRepository: locator<AuthenticationRepository>()));
  locator.registerFactory(
      () => DatabaseBloc(databaseRepository: locator<DatabaseRepository>()));
  locator.registerFactory(() => FormBloc(
      authenticationRepository: locator<AuthenticationRepository>(),
      databaseRepository: locator<DatabaseRepository>()));
  locator.registerFactory(() => BiometricBloc(biometricRepository: locator<BiometricRepository>()));

  // locator.registerSingleton<Box<Todo>>(
  //   Hive.box('HiveTodos')
  // );
}
