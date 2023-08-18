import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_firestore_service.dart';

class FirebaseAuthService {
  static Future<bool> loginWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      //ignored for now
    }
    return FirebaseAuth.instance.currentUser != null;
  }

  static Future<bool> signupWithEmailAndPassword(
      BuildContext context, String email, String password, String role) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      //ignored for now
    }
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestoreService.addUserData(
          FirebaseAuth.instance.currentUser!.email ?? "",
          FirebaseAuth.instance.currentUser!.uid,
          role);
    }
    return FirebaseAuth.instance.currentUser != null;
  }

  static Future<void> deleteUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser!.delete();
    }
  }
}
