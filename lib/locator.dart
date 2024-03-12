import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:text_editor_test/features/todo/data/datasource/todo_list_service.dart';
import 'package:text_editor_test/features/todo/data/datasource/todo_service.dart';
GetIt locator = GetIt.instance;

Future<void> initDependency() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Todo>(TodoAdapter());
  Hive.registerAdapter(TodoStatusAdapter());
  Hive.registerAdapter(LocalListAdapter());
  Hive.registerAdapter(ListStatusAdapter());
  // await Hive.openBox<Todo>('HiveTodos');


  // locator.registerSingleton<Box<Todo>>(
  //   Hive.box('HiveTodos')
  // );

  
 
}