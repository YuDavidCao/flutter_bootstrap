import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  StreamSubscription<DocumentSnapshot>? _subscription;
  User? _user = FirebaseAuth.instance.currentUser;
  String? _role;
  String? _username;

  User? get user => _user;
  String get email => _user!.email ?? "";
  String get id => _user!.uid;
  String? get role => _role;
  String? get username => _username;

  set role(String? value) {
    _role = value;
  }

  set username(String? value) {
    _username = value;
  }

  UserState() {
    reinitialize();
  }

  void reinitialize() {
    _subscription?.cancel();
    FirebaseAuth.instance.authStateChanges().listen((event) {
      _user = event;
      notifyListeners();
    });
    _subscription = FirebaseFirestore.instance
        .collection("User")
        .doc(_user!.email)
        .snapshots()
        .listen((snapshot) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      role = data["role"];
      username = data["name"];
      notifyListeners();
    });
  }
}
