
import 'package:text_editor_test/features/auth/data/user.dart';
import 'database_service.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService service = DatabaseService();

  @override
  Future<void> saveUserData(MyUser user) {
    return service.addUserData(user);
  }

  @override
  Future<List<MyUser>> retrieveUserData() {
    return service.retrieveUserData();
  }
}

abstract class DatabaseRepository {
  Future<void> saveUserData(MyUser user);
  Future<List<MyUser>> retrieveUserData();
}
