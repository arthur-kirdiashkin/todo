import 'package:text_editor_test/features/todo/data/datasource/encrypt_data_service.dart';

abstract class EncryptRepository {
 Future<void> encryptAndSave(String password, String data);
  Future<String?> decrypt(String password);
}


class EncryptRepositoryImpl implements EncryptRepository{
  EncryptDataService encryptDataService = EncryptDataService();
  
  @override
  Future<String?> decrypt(String password) async {
    return await encryptDataService.decrypt(password);
  }
  
  @override
  Future<void> encryptAndSave(String password, String data) async {
    return await encryptDataService.encryptAndSave(password, data);
  }

 

}