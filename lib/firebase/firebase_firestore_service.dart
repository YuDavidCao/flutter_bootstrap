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
        "name": email.substring(0, 2).toUpperCase(),
        "role": role
      });
    }
  }
}
