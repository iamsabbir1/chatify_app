import 'package:cloud_firestore/cloud_firestore.dart';

const String userCollection = 'Users';
const String chatCollection = 'Chats';
const String messageCollection = 'Messages';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DatabaseService();

  Future<DocumentSnapshot> getUser(String uid) {
    return _firestore.collection(userCollection).doc(uid).get();
  }

  Future<void> createUser(
      String uid, String email, String name, String imageURL) async {
    try {
      await _firestore.collection(userCollection).doc(uid).set({
        'email': email,
        'name': name,
        'image': imageURL,
        'last_active': DateTime.now().isUtc,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserLastSeenTime(String uid) async {
    try {
      await _firestore.collection(userCollection).doc(uid).update({
        'last_active': DateTime.now().isUtc,
      });
    } catch (e) {
      print(e);
    }
  }
}
