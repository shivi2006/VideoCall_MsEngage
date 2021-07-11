import 'package:flutter/foundation.dart';

// User Model class
class User {
  final String uid;
  final String name;
  final String email;

  User({
    @required this.uid,
    @required this.name,
    @required this.email,
  });

  factory User.fromMap(Map<String, dynamic> map) => User(
        uid: map['uid'].toString(),
        name: map['name'],
        email: map['email'].toString(),
      );

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
}
