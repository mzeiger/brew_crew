import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:brew_crewirebase/models/user.dart';
import '../shared/registration_signin_return_structure.dart';
import 'database.dart';

class AuthService {
  // create User object based on FirebaseUser (UserCredential)
  UserUID? _userFromFirebaseUser(User user) {
    return user != null ? UserUID(uid: user.uid) : null;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change user stream
  Stream<User?> get user {
    //return _auth.authStateChanges().map((User user)  => _userFromFirebaseUser(user);
    return _auth.userChanges();
  }

  // Sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      //return user?.uid;
      return RegistrationSignInReturn(description: "", flag: user!.uid);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      //return null;
      return RegistrationSignInReturn(description: e.toString(),flag: null);
    }
  }

  // Register email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updateUserData('0', 'new crew member', 100);
      //return user.uid;
      return RegistrationSignInReturn(description: "", flag: user.uid);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      //return null;
      return RegistrationSignInReturn(description: e.toString(),flag: null);
    }
  }

  // Sign out
  Future signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
