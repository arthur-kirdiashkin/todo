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

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'email': email,
  //     'name': name,
  //   };
  // }

  // factory MyUser.fromJson(Map<String, dynamic> doc) {
  //   return MyUser(
  //     email: doc['email'],
  //     name: doc['name'],
  //     id: doc['id'],
  //   );
  // }

  // @override
  // List<Object?> get props => [
  //       id,
  //       email,
  //       name,
  //     ];
}


// import 'package:equatable/equatable.dart';


// enum AccountType {
//   buy,
//   sell,
// }

// enum EmailVerificationStatus {
//   verified(0),
//   unverified(1),
//   sent(2);

//   final int value;
//   const EmailVerificationStatus(this.value);

//   static EmailVerificationStatus fromInt(int value) {
//     return EmailVerificationStatus.values.firstWhere((e) => e.value == value);
//   }
// }





