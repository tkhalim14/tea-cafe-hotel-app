import 'package:tea_coffee_app/models/item.dart';

import '../models/user.dart';
import './database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebase user
  MyUser? _userfromfirebase(User? user) {
    //print(user.toString());
    if(user==null){
      return null;
    }
    else{
      return MyUser(uid: user.uid, email: user.email.toString());
    }
  }

  //auth change user stream

  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        //.map((User? user) => _userfromfirebase(user!));
        .map(_userfromfirebase);
  }
  //sign in anonymously

  // Future signinanon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User? user = result.user;
  //     return _userfromfirebase(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
  //sign in with email & password

  Future registerwithemailandpassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //create a new document for the user with new uid
      Beverages beverage = Beverages(name: '', sugars: '0', size: 100, strength: 0, type: '');

      await DatabaseService(uid: user!.uid)
          .updateUserData(user.email.toString(), beverage);
      return _userfromfirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signinwithemailandpassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userfromfirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
