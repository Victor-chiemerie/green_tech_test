import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../Model/user.dart';

class FirebaseRepository {
  // Firebase Firestore instance
  FirebaseRepository({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');

  // stream user auth
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((User? firebaseUser) {
      if (firebaseUser != null) {
        final user = firebaseUser;
        return user;
      }
      return null;
    });
  }

  /// Sign up
  Future<myUser> signUp(
    myUser myUser,
    String password,
  ) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );

      // set the user created details to the details gotten from firebase
      myUser = myUser.copyWith(id: user.user!.uid);

      // save the newly created user in the user collection
      await userCollection.doc(myUser.email).set(myUser.toDocument());

      return myUser;
    } catch (error) {
      debugPrint('Error signing up: $error');
      // Handle error appropriately
      rethrow;
    }
  }

  // Sign In
  Future<void> signIn(
    String email,
    String password,
  ) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      debugPrint('Error signing in: $error');
      rethrow;
    }
  }

  // Sign Out
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      debugPrint("Error logging out: $error");
      rethrow;
    }
  }

  // Get user data
  Future<myUser?> getUser(String email) async {
    try {
      final docSnapshot = await userCollection.doc(email).get();

      if (!docSnapshot.exists) {
        throw Exception('user_not_found');
      }

      final data = docSnapshot.data();

      if (data == null) {
        throw Exception('empty_data');
      }

      return myUser.fromDocument(data);
    } catch (e) {
      debugPrint('Error getting user: $e');
      return null;
    }
  }
}
