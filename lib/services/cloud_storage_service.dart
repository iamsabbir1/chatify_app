import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

const String USER_COLLECTION = 'Users';

class CloudStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  CloudStorageService();

  Future<String?> saveUserImageToStorage(String uid, File file) async {
    try {
      print(file.);
      Reference ref = _storage.ref().child('images/users/$uid/$file');
      UploadTask task = ref.putFile(file);
      return await task.then((result) {
        return result.ref.getDownloadURL();
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> saveChatImageToStorage(
      String chatId, String userId, File file) async {
    try {
      Reference ref = _storage.ref().child(
          'images/chats/$chatId/${userId}_${Timestamp.now().microsecondsSinceEpoch}.jpg');
      UploadTask task = ref.putFile(file);
      return task.then((result) {
        return result.ref.getDownloadURL();
      });
    } catch (e) {
      print(e);
      return null;
    }
  }
}
