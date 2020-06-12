import 'package:firebase_auth/firebase_auth.dart';
import 'package:poolheatercalculator/core/models/user.dart';
import 'package:poolheatercalculator/core/services/firebase_utils.dart';
import 'package:poolheatercalculator/locator.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  FirebaseUtils firebaseUtils = locator<FirebaseUtils>();

  Future<User> login() async {
    return firebaseUtils.login();
  }

  Future<bool> updateOrInsertUserToken(User user) async {
    return firebaseUtils.updateOrInsertUser(user);
  }

  Future<String> getCurrentUser() {
    return FirebaseUtils.getCurrentUser();
  }
}
