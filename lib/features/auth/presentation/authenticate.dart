// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart' as auth;
// import 'package:text_editor_test/features/auth/data/user.dart';



// class FireStoreUtils {
//   static FirebaseFirestore firestore = FirebaseFirestore.instance;

//   static Future<User?> getCurrentUser(String uid) async {
//     DocumentSnapshot<Map<String, dynamic>> userDocument =
//         await firestore.collection('users').doc(uid).get();
//     if (userDocument.data() != null && userDocument.exists) {
//       return User.fromJson(userDocument.data()!);
//     } else {
//       return null;
//     }
//   }

//   static Future<User> updateCurrentUser(User user) async {
//     return await firestore
//         .collection('users')
//         .doc(user.userId)
//         .set(user.toJson())
//         .then((document) {
//       return user;
//     });
//   }


  

//   /// login with email and password with firebase
//   /// @param email user email
//   /// @param password user password
//   static Future<dynamic> loginWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       auth.UserCredential result = await auth.FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
//           await firestore.collection('users').doc(result.user?.uid ?? '').get();
//       User? user;
//       if (documentSnapshot.exists) {
//         user = User.fromJson(documentSnapshot.data() ?? {});
//       }
//       return user;
//     } on auth.FirebaseAuthException catch (exception, s) {
//       switch ((exception).code) {
//         case 'invalid-email':
//           return 'Email address is malformed.';
//         case 'wrong-password':
//           return 'Wrong password.';
//         case 'user-not-found':
//           return 'No user corresponding to the given email address.';
//         case 'user-disabled':
//           return 'This user has been disabled.';
//         case 'too-many-requests':
//           return 'Too many attempts to sign in as this user.';
//       }
//       return 'Unexpected firebase error, Please try again.';
//     } catch (e, s) {
//       return 'Login failed, Please try again.';
//     }
//   }

//   /// save a new user document in the USERS table in firebase firestore
//   /// returns an error message on failure or null on success
//   static Future<String?> createNewUser(User user) async => await firestore
//       .collection('users')
//       .doc(user.userId)
//       .set(user.toJson())
//       .then((value) => null, onError: (e) => e);

//   static signUpWithEmailAndPassword(
//       {required String emailAddress,
//       required String password,
//       File? image,
//       firstName = 'Anonymous',
//       lastName = 'User'}) async {
//     try {
//       auth.UserCredential result = await auth.FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//               email: emailAddress, password: password);
//       String profilePicUrl = '';
//       User user = User(
  
//           email: emailAddress,
//           firstName: firstName,
//           userId: result.user?.uid ?? '',
//           lastName: lastName,
//           profilePictureURL: profilePicUrl);
//       String? errorMessage = await createNewUser(user);
//       if (errorMessage == null) {
//         return user;
//       } else {
//         return 'Couldn\'t sign up for firebase, Please try again.';
//       }
//     } on auth.FirebaseAuthException catch (error) {
//       String message = 'Couldn\'t sign up';
//       switch (error.code) {
//         case 'email-already-in-use':
//           message = 'Email already in use, Please pick another email!';
//           break;
//         case 'invalid-email':
//           message = 'Enter valid e-mail';
//           break;
//         case 'operation-not-allowed':
//           message = 'Email/password accounts are not enabled';
//           break;
//         case 'weak-password':
//           message = 'Password must be more than 5 characters';
//           break;
//         case 'too-many-requests':
//           message = 'Too many requests, Please try again later.';
//           break;
//       }
//       return message;
//     } catch (e) {
//       return 'Couldn\'t sign up';
//     }
//   }

//   static logout() async {
//     await auth.FirebaseAuth.instance.signOut();
//   }

//   static Future<User?> getAuthUser() async {
//     auth.User? firebaseUser = auth.FirebaseAuth.instance.currentUser;
//     if (firebaseUser != null) {
//       User? user = await getCurrentUser(firebaseUser.uid);
//       return user;
//     } else {
//       return null;
//     }
//   }





//   static resetPassword(String emailAddress) async =>
//       await auth.FirebaseAuth.instance
//           .sendPasswordResetEmail(email: emailAddress);
// }
