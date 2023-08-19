import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClassroomState with ChangeNotifier {
  StreamSubscription<QuerySnapshot>? _subscription;
  List<DocumentSnapshot> _loadedClassroom = [];
  late String _currentUserEmail;

  String get currentUserEmail => _currentUserEmail;

  set currentUserEmail(String value) {
    _currentUserEmail = value;
  }

  final Query<Map<String, dynamic>> _currentQuery =
      FirebaseFirestore.instance.collection("Classroom");

  List<DocumentSnapshot> get loadedClassroom => _loadedClassroom;

  set loadedClassroom(List<DocumentSnapshot> value) {
    _loadedClassroom = value;
  }

  late String _classId;

  String get classId => _classId;

  set classId(String value) {
    _classId = value;
  }

  ClassroomState(String currentUserEmail) {
    _currentUserEmail = currentUserEmail;
    loadClassroom();
  }

  void loadClassroom() {
    _subscription?.cancel();
    _subscription = _currentQuery.snapshots().listen((querySnapshot) {
      List<DocumentSnapshot> temp;
      temp = querySnapshot.docs;
      for (int i = 0; i < temp.length; i++) {
        if (!temp[i]["Student"].contains(currentUserEmail) &&
            !temp[i]["Instructor"].contains(currentUserEmail)) {
          _loadedClassroom.add(temp[i]);
        }
      }
      notifyListeners();
    });
  }
}
