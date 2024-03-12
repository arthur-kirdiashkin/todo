import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:text_editor_test/features/auth/data/user.dart';



class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

   Future<MyUser?> addUserData(MyUser userData) async {
    await _db.collection("Users").doc(userData.uid).set(userData.toMap());
  }

    Future<List<MyUser>> retrieveUserData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Users").get();
    return snapshot.docs
        .map((docSnapshot) => MyUser.fromDocumentSnapshot(docSnapshot))
        .toList();
    }

        Future<String> retrieveUserName(MyUser user) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Users").doc(user.uid).get();
    return snapshot.data()!["displayName"];
    }
}
