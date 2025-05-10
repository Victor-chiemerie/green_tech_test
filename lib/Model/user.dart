// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types
import 'package:equatable/equatable.dart';

class myUser extends Equatable {
  final String id;
  final String email;
  final String username;
  
  const myUser({
    required this.id,
    required this.email,
    required this.username,
  });

  /// Empty user which represents an unauthenticated user
  static myUser empty = myUser(
    id: "",
    email: "",
    username: "",
  );

  myUser copyWith({
    String? id,
    String? email,
    String? username,
  }) {
    return myUser(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toDocument() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'username': username,
    };
  }

  factory myUser.fromDocument(Map<String, dynamic> map) {
    return myUser(
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
    );
  }
  
  @override
  List<Object?> get props => [id, email, username];
}
