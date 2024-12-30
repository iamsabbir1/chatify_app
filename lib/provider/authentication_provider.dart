import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../services/database_service.dart';
import '../services/navigation_service.dart';

//models
import '../models/chat_user.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;

  late ChatUser chatUser;
  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();
    _auth.signOut();
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print('authenticated');
        _databaseService.updateUserLastSeenTime(user.uid);
        _databaseService.getUser(user.uid).then((snapshot) {
          Map<String, dynamic> userData =
              snapshot.data() as Map<String, dynamic>;
          chatUser = ChatUser.fromJSON({
            'uid': user.uid,
            'name': userData['name'],
            'email': userData['email'],
            'image': userData['image'],
            'last_active': userData['last_active'],
          });
        });
        _navigationService.removeAndNavigateToRoute('/home');
      } else {
        _navigationService.removeAndNavigateToRoute('/login');
        print('not authenticated');
      }
    }).onError((error, stackTrace) {
      print('error');
    });
  }

  Future<void> loginUsingEmailAndPassword(String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
      print(_auth.currentUser);
    } on FirebaseAuthException {
      print('Error login with user in firebase');
    } catch (e) {
      print(e);
    }
  }

  Future<String?> registerUsingEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user?.uid;
    } on FirebaseAuthException {
      print('error registering user');
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
