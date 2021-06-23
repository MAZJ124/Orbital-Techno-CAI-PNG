import 'package:firebase_auth/firebase_auth.dart';
import 'package:nus_spots/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on User
  NUSer _userFromFirebase(User user) {
    return user != null ? NUSer(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<NUSer> get user {
    return _auth.authStateChanges().map((User user) => _userFromFirebase(user));
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email/pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebase(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email & pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
       UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       User user = result.user;
       return _userFromFirebase(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}