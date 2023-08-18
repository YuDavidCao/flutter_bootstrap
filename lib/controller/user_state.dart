import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  StreamSubscription<DocumentSnapshot>? _subscription;
  User? _user = FirebaseAuth.instance.currentUser;

  User? get user => _user;
  String get email => _user!.email ?? "";
  String get id => _user!.uid;

  UserState(){
    reinitialize();
  }

  void reinitialize() {
    _subscription?.cancel();
    FirebaseAuth.instance.authStateChanges().listen((event) {
      _user = event;
      notifyListeners();
    });
  }
}
