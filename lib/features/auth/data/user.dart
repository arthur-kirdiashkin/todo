class MyUser {
  final String? id;
  final String? email;
  final String? name;

  MyUser({
    required this.id,
    required this.email,
    required this.name,
  });

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  factory MyUser.fromJson(Map<String, dynamic> doc) {
    return MyUser(
      email: doc['email'],
      name: doc['name'],
      id: doc['id'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
      ];
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





// class User extends Equatable {
//   final String userId;
//   final String email;
//   final String firstName;
//   final String lastName;
//   final String? profilePictureURL;
//   final EmailVerificationStatus emailVerification;
 
//   final double balance;
//   final int availableTags;
//   AccountType accountType;
//   final List<String>? savedFilters;

//   static User empty = User(
//     userId: '',
//     email: '',
//     firstName: '',
//     lastName: '',
//   );


//   String fullName() => '$firstName $lastName';

//   bool get isEmpty => this == User.empty;

//   bool get isNotEmpty => this != User.empty;

//   User({
  
//     required this.userId,
//     required this.email,
//     required this.firstName,
//     required this.lastName,
//     this.profilePictureURL,
//     this.emailVerification = EmailVerificationStatus.unverified,
//     this.balance = 0.0,
//     this.availableTags = 3,
//     this.accountType = AccountType.buy,
//     this.savedFilters,
//   });

//   factory User.fromJson(
//     Map<String, dynamic> parsedJson,
//   ) {
//     return User(
//       userId: parsedJson['userId'] ?? '',
//       email: parsedJson['email'] ?? '',
//       firstName: parsedJson['firstName'] ?? '',
//       lastName: parsedJson['lastName'] ?? '',
//       profilePictureURL: parsedJson['profilePictureURL'] ?? '',
//       balance: parsedJson['balance'] ?? 0.0,
//       availableTags: parsedJson['availableTags'] ?? 0,
//       savedFilters: null,
//       emailVerification:
//           EmailVerificationStatus.fromInt(parsedJson['emailVerification'] ?? 1),
  
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'userId': userId,
//       'email': email,
//       'firstName': firstName,
//       'lastName': lastName,
//       'profilePictureURL': profilePictureURL,
//       'emailVerification': emailVerification.value,

//       'balance': balance,
//       'availableTags': availableTags,
//     };
//   }

//   User copyWith({
//     String? profilePictureURL,
//     EmailVerificationStatus? emailVerification,
//     double? balance,
//     int? availableTags,
//     AccountType? accountType,
  

//   }) {
//     return User(

//       userId: userId,
//       email: email,
//       firstName: firstName,
//       lastName: lastName,
//       profilePictureURL: profilePictureURL ?? this.profilePictureURL,
//       emailVerification: emailVerification ?? this.emailVerification,
//       balance: balance ?? this.balance,
//       availableTags: availableTags ?? this.availableTags,
//       accountType: accountType ?? this.accountType,
//       savedFilters: savedFilters,

//     );
//   }

//   @override
//   List<Object?> get props => [
//         userId,
//         email,
//         firstName,
//         lastName,
//         profilePictureURL,
//         emailVerification,
//         balance,
//         availableTags,
//         accountType,
//         savedFilters,
//       ];
// }
