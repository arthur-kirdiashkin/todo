import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String? uid;
  final String? email;
  final String? displayName;
  String? password;
  bool? isVerified;
  final int? age;
  MyUser({
    this.age,
    this.uid,
    this.email,
    this.displayName,
    this.password,
    this.isVerified,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'age': age,
    };
  }

  MyUser.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        age = doc.data()!['age'],
        email = doc.data()!["email"],
        displayName = doc.data()!["displayName"];
        

  MyUser copyWith({
    bool? isVerified,
    String? uid,
    String? email,
    String? password,
    String? displayName,
    int? age,
  }) {
    return MyUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
      displayName: displayName ?? this.displayName,
      isVerified: isVerified ?? this.isVerified,
    );
  }

}








