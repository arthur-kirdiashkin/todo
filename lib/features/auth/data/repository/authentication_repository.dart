import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_editor_test/features/auth/data/repository/authentication_service.dart';
import 'package:text_editor_test/features/auth/data/user.dart';
import 'package:text_editor_test/features/auth/database/database_service.dart';


abstract class AuthenticationRepository {

  Stream<MyUser> getCurrentUser();


  Future<UserCredential?> signUp(MyUser user);

  Future<UserCredential?> signIn(MyUser user);

  Future<void> signOut();

  Future<String?> retrieveUserName(MyUser user);
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {

  AuthenticationService service = AuthenticationService();
  DatabaseService dbService = DatabaseService();
  
  @override
  Stream<MyUser> getCurrentUser() {
    return service.retrieveCurrentUser();
  }

  @override
  Future<UserCredential?> signUp(MyUser user) {
    try {
      return service.signUp(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<UserCredential?> signIn(MyUser user) {
    try {
      return service.signIn(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<void> signOut() {
    return service.signOut();
  }

  @override
  Future<String?> retrieveUserName(MyUser user) {
    return dbService.retrieveUserName(user);
  }
}

  

