import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  static void addUserData(String email, String username, String role) async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('User');
    DocumentSnapshot documentSnapshot =
        await collectionReference.doc(email).get();
    if (!documentSnapshot.exists) {
      collectionReference.doc(email).set({
        "email": email,
        "name": username,
        "role": role,
        "classes": <String>[]
      });
    }
  }

  static void addClassroom(String title, String description, String userEmail,
      String username) async {
    DocumentReference id =
        await FirebaseFirestore.instance.collection("Classroom").add({
      "Title": title,
      "Description": description,
      "Instructor": [userEmail],
      "Student": [],
    });
    FirebaseFirestore.instance.collection("User").doc(userEmail).update({
      "classes": FieldValue.arrayUnion([id.id])
    });
    FirebaseFirestore.instance
        .collection("Classroom")
        .doc(id.id)
        .collection("Post")
        .add({
      "userEmail": userEmail,
      "Message": "Classroom created by $username",
      "time": DateTime.now(),
    });
  }
}
