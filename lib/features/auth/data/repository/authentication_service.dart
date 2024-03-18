import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_editor_test/features/auth/data/user.dart';

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<MyUser> retrieveCurrentUser() {
    // return auth.authStateChanges().listen((User? user) { 
    //   if(user != null) {
    //     return MyUser(uid: user.uid, email: user.email,);
    //   } else {
    //     return MyUser(uid: "uid",);
    //   }
    // });
    
    return auth.authStateChanges().map((User? user) {
      print(user?.email);
      if (user != null) {
        return MyUser(uid: user.uid, email: user.email,);
      } else {
        return  MyUser(uid: "uid",);
      }
    });
  }

  Future<UserCredential?> signUp(MyUser user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user.email!,password: user.password!);
          await verifyEmail();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<UserCredential?> signIn(MyUser user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user.email!, password: user.password!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<void> verifyEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    print(user);
    if (user != null && !user.emailVerified) {
       try {
         await user!.sendEmailVerification();
       } catch (e) {
         throw Exception(e.toString());
       }
       
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }


}