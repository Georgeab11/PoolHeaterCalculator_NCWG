import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poolheatercalculator/core/models/user.dart';
import 'package:poolheatercalculator/locator.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUtils {
  static Firestore _firestore = Firestore.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<String> getCurrentUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      String uid = firebaseUser.uid;
      return uid;
    } else {
      return null;
    }
  }

  Future<bool> updateOrInsertUser(User user) async {
    try {
      await _firestore
          .collection("users")
          .document(user.uid)
          .setData(user.toJson());
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> updateUserToken(uid, token) async {
    try {
      await _firestore
          .collection("users")
          .document(uid)
          .updateData({"token": token});
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<User> login() async {
    // Example code of how to sign in with google.
    print('login called');
    User myUser = new User();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    myUser.uid = user.uid;
    myUser.email = user.email;

    return myUser;
  }

  static Future<void> saveReading(Map<String, dynamic> json) async {
    if (json['uid'] != null) {
      return _firestore
          .collection("readings")
          .document(json['uid'])
          .updateData(json);
    } else {
      json['userId'] = await getCurrentUser();
      return _firestore.collection("readings").add(json);
    }
  }

  static Stream<QuerySnapshot> getAllReadingsForCurrentUser(
      String currentUser) {
    return _firestore
        .collection('readings')
        .where('userId', isEqualTo: currentUser)
        .snapshots();
  }

  static Future<void> deleteEntry(String uid) {
    return _firestore.collection('readings').document(uid).delete();
  }
}
