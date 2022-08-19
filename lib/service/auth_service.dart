import 'package:appchat/helper/helper_function.dart';
import 'package:appchat/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Logins
  Future loginWithUserWintNameandPasword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        //memangil databas service dan update data user

        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  //register
  Future registerUserWintEmaillandPasword(
      fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        //memangil databas service dan update data user
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);

        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  //Sigout

  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF('');
      await HelperFunctions.saveUserNameSF('');
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
