import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClassroomState with ChangeNotifier {
  StreamSubscription<QuerySnapshot>? _subscription;
  List<DocumentSnapshot> _loadedActivity = [];

  List<DocumentSnapshot> get loadedActivity => _loadedActivity;

  set loadedActivity(List<DocumentSnapshot> value) {
    _loadedActivity = value;
  }

  late String _classId;
  late Query<Map<String, dynamic>> _currentQuery;

  String get classId => _classId;

  set classId(String value) {
    _classId = value;
  }

  ClassroomState(String classId) {
    classId = classId;
    _currentQuery = FirebaseFirestore.instance
        .collection("Classroom")
        .doc(classId)
        .collection("Post")
        .orderBy('Time', descending: false);
    loadClassroomActivity();
  }

  void loadClassroomActivity() {
    _subscription?.cancel();
    _subscription = _currentQuery.snapshots().listen((querySnapshot) {
      loadedActivity = querySnapshot.docs;
      notifyListeners();
    });
  }
}
