import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plumbify/Controller/UserController.dart';
import 'package:plumbify/model/user.dart';
abstract class AuthBase {

  User get currentUser;

  Stream<User> authStateChanges();

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User> createUserWithEmailAndPassword(String email, String password,String name);

  Future<User> signInWithGoogle();

  Future<User> signInWithFacebook();

  Future<void> sendPasswordResetEmail (String email);

  Future<void> signOut();


}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  UserController userController = Get.find(tag:'user_controller');

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();


  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );
    return userCredential.user;
  }


  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User firebaseUser = userCredential.user;
    firebaseUser.updateProfile( displayName: name);
    firebaseUser.reload();
    USer user = USer(uid: firebaseUser.uid,

        profile_pic: firebaseUser.photoURL,
        phone: '',
        nearby_address: '',
        geoPoint: GeoPoint(0,0),
        full_address: '',
        email: firebaseUser.email,
        name: name,

    );

    userController.postUser(user);

    return firebaseUser;
  }


  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if(googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken
        ));
        return userCredential.user;
      } else {
        throw FirebaseAuthException(code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',message: 'Missing Google ID Token');
      }
    } else {
      throw FirebaseAuthException(message: 'Sign in aborted by User', code: 'ERROR_ABORTED_BY_USER');
    }

  }
  @override
  Future<User> signInWithFacebook() async {
    final fb = FacebookLogin();
    final response = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (response.status) {
      case FacebookLoginStatus.success:
        final accessToken = response.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(accessToken.token),
        );
        return userCredential.user;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: response.error.developerMessage,
        );
      default:
        throw UnimplementedError();
    }
  }
  @override
  Future<void> sendPasswordResetEmail (email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);

  }


  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}
