import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe_app/controllers/user_controller.dart';

class AuthenticatorService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> createUser({
    required String userEmail,
    required String userPassword,
})async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword
        (email: userEmail, password: userPassword);
      return userCredential;

    } on FirebaseAuthException{
      rethrow;
    }
    catch(e){
      throw Exception('Failed to create user');
    }
  }

  Future<UserCredential?> loginUser({
    required String email,
    required String password,
})async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential;
    } on FirebaseAuthException{
      rethrow;
    }
    catch(e){
      throw Exception('failed to login user');
    }
  }

  Future<GoogleSignInAccount?> googleAuth()async{
    try{
      final googleSignIn = GoogleSignIn(); // initialize the google_signin package

      // Sign out the user to ensure the account selection screen appears.
      //await googleSignIn.signOut();

    final googleUser = await googleSignIn.signIn();//start the signin process
    if(googleUser == null) return null;// user cancels the process

    final googleAuth = await googleUser.authentication;// get authentication details

// create a credential for firebase
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
    );
    await FirebaseAuth.instance.signInWithCredential(credential);// signin with the credential

      Get.find<UserController>().setUser(
          userName: googleUser.displayName ?? '',
          photoUrl: googleUser.photoUrl ?? '',
      );

      return googleUser; // return the signed-in user's information

    }catch(e){
      print("Error during Google Sign-In: $e");
      rethrow;
    }
    return null;

  }
}