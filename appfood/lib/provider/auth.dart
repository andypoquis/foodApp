import 'dart:async';
import 'package:appfood/helper/constants.dart';
import 'package:appfood/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  User? _user;
  Status _status = Status.Uninitialized;
  //UserServices _userServices = UserServices();

  late UserModel _userModel;
  GoogleSignIn _googleSignIn = GoogleSignIn();

//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  User get user => _user!;

  AuthProvider.init() {
    _fireSetUp();
  }

  void _fireSetUp() async {
    await initialization.then((value) {
      auth.authStateChanges().listen(_onStateChanged);
    });
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await auth.signInWithCredential(credential).then((userCredentials) async {
        // _user = userCredentials.user;
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString("id", _user.uid);
        //  if (!await _userServices.doesUserExist(_user.uid)) {
        //   _userServices.createUser(
        //       id: _user.uid, name: _user.displayName, photo: _user.photoURL);
        //   await initializeUserModel();
        // } //else {
        //   await initializeUserModel();
        // }
      });
      return {'success': true, 'message': 'success'};
    } catch (e) {
      notifyListeners();
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> verifyLogin() async {
    return {'success': true, 'message': 'success'};
  }

  // Future<Map<String, dynamic>> sigInWithFacebook() async {
  //   try {
  //      final LoginResult result = await FacebookAuth.instance.login();
  //   switch (result.status) {
  //     case LoginStatus.success:
  //       final AuthCredential facebookCredential =
  //           FacebookAuthProvider.credential(result.accessToken!.token);
  //       final userCredential =
  //           await _auth.signInWithCredential(facebookCredential);
  //       return Resource(status: Status.Success);
  //     case LoginStatus.cancelled:
  //       return Resource(status: Status.Cancelled);
  //     case LoginStatus.failed:
  //       return Resource(status: Status.Error);
  //     default:
  //       return null;
  //     }
  //     return {'success': true, 'message': 'success'};
  //   } catch (e) {
  //     notifyListeners();
  //     return {'success': false, 'message': e.toString()};
  //   }
  // }

  Future<Map<String, dynamic>> createUserEmail(email, password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;

    return {'success': true, 'message': 'success'};
  }

  Future<bool> initializeUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? _userId = preferences.getString('id');
    //_userModel = await _userServices.getUserById(_userId);
    notifyListeners();
    if (_userModel == null) {
      return false;
    } else {
      return true;
    }
  }

  Future signOut() async {
    auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  _onStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
      notifyListeners();
    } else {
      _user = firebaseUser;
      initializeUserModel();
      Future.delayed(const Duration(seconds: 2), () {
        _status = Status.Authenticated;
        notifyListeners();
      });
    }
  }
}
