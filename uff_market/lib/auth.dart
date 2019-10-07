import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class AuthService{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Observable <FirebaseUser> user;
  Observable <Map <String, dynamic>> profile;
  PublishSubject loading = PublishSubject();
  
  AuthService(){
    user = Observable(_auth.onAuthStateChanged);
    profile = user.switchMap((FirebaseUser u){
      if (u != null){
        return _db.collection('users').document(u.uid).snapshots().map((snap) => snap.data);
      }
      else{
        return Observable.just({});
      }
    });
  }

   Future<FirebaseUser> handleSignIn() async {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final AuthResult authResult = await _auth.signInWithCredential(credential);
      FirebaseUser user = authResult.user;
      print("signed in " + user.displayName);
      return user;
    }
  void updateUserData(FirebaseUser user) async{
    DocumentReference ref = _db.collection('users').document(user.uid);
    return ref.setData({ 
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
     }, merge: true);
  }

  void  signOut() async{
     await FirebaseAuth.instance.signOut();
     await _googleSignIn.signOut();
  }

  Future<String> getUID() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    return uid;
  }

}

final AuthService authService = AuthService();
