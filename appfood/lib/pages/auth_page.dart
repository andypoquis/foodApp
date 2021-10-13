import 'package:appfood/database/database.dart';
import 'package:appfood/helper/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late Database db;
  bool isButtom = false;
  void initState() {
    db = Database();
    db.initliase();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    final _sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: _sizeScreen.width,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Container(
                    width: _sizeScreen.width,
                    child: SvgPicture.asset(
                      'assets/logo.svg',
                    ),
                  ),
                )),
            Expanded(
              flex: 2,
              child: Container(
                width: _sizeScreen.width,
                child: Column(
                  children: [
                    buttonLogin(
                      _sizeScreen,
                      context,
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // buttonSignIn(_sizeScreen),
                    SizedBox(
                      height: 20,
                    ),
                    buttonGoogle(_sizeScreen, context),
                    SizedBox(
                      height: 20,
                    ),
                    buttonFacebook(_sizeScreen),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonLogin(final _sizeScreen, context) {
    return Container(
      width: _sizeScreen.width * 0.75,
      height: 50,
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(252, 175, 3, 1)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black54),
            overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return Colors.yellow.withOpacity(0.04);
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed))
                  return Colors.yellow.withOpacity(0.12);
                return Colors.yellow
                    .withOpacity(0.12); // Defer to the widget's default.
              },
            ),
          ),
          onPressed: () async {
            //sigInPage(_sizeScreen, context, appProvider, authProvider);
          },
          child: Text('Iniciar Sesion')),
    );
  }

  Widget buttonSignIn(final _sizeScreen) {
    return Container(
      width: _sizeScreen.width * 0.75,
      height: 50,
      child: TextButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color?>(Colors.grey[100]),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black54),
            overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return Colors.yellow.withOpacity(0.04);
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed))
                  return Colors.yellow.withOpacity(0.12);
                return Colors.yellow.withOpacity(0.12);
                // Defer to the widget's default.
              },
            ),
          ),
          onPressed: () {},
          child: Text('Registrarse')),
    );
  }

  Widget buttonGoogle(final _sizeScreen, context) {
    return Container(
      width: _sizeScreen.width * 0.75,
      height: 50,
      child: TextButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color?>(Colors.grey[100]),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black54),
            overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return Colors.yellow.withOpacity(0.04);
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed))
                  return Colors.yellow.withOpacity(0.12);
                return Colors.yellow.withOpacity(0.12);
                // Defer to the widget's default.
              },
            ),
          ),
          onPressed: () async {
            try {
              setState(() {
                isButtom = true;
              });
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLogin', true);
              final GoogleSignInAccount? googleUser =
                  await _googleSignIn.signIn();
              final GoogleSignInAuthentication googleAuth =
                  await googleUser!.authentication;

              final AuthCredential credential = GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken,
              );
              await auth
                  .signInWithCredential(credential)
                  .then((userCredentials) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString(
                    'id_user', userCredentials.user!.email.toString());

                //-------------------

                bool isExistsUser =
                    await checkExist(userCredentials.user!.email);

                if (!isExistsUser) {
                  db.createUser(
                      userCredentials.user!.phoneNumber.toString(),
                      userCredentials.user!.email.toString(),
                      userCredentials.user!.displayName.toString());
                }

                //print(isExistsUser);
              });

              Future.delayed(const Duration(milliseconds: 6000), () {
                setState(() {
                  Navigator.pop(context, true);
                });
              });
            } catch (e) {}
          },
          child: isButtomTap()),
    );
  }

  Widget buttonFacebook(
    final _sizeScreen,
  ) {
    return Container(
      width: _sizeScreen.width * 0.75,
      height: 50,
      child: TextButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color?>(Colors.grey[100]),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black54),
            overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return Colors.yellow.withOpacity(0.04);
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed))
                  return Colors.yellow.withOpacity(0.12);
                return Colors.yellow.withOpacity(0.12);
                // Defer to the widget's default.
              },
            ),
          ),
          onPressed: () async {
            //     final FacebookLoginResult result =
            //         await LoginPage.facebookSignIn.logIn(['email']);
            //     switch (result.status) {
            //       case FacebookLoginStatus.loggedIn:
            //         final FacebookAccessToken accessToken = result.accessToken;
            //         print('''
            //  Logged in!

            //  Token: ${accessToken.token}
            //  User id: ${accessToken.userId}
            //  Expires: ${accessToken.expires}
            //  Permissions: ${accessToken.permissions}
            //  Declined permissions: ${accessToken.declinedPermissions}
            //  ''');
            //         break;
            //       case FacebookLoginStatus.cancelledByUser:
            //         print('Login cancelled by the user.');
            //         break;
            //       case FacebookLoginStatus.error:
            //         print('Something went wrong with the login process.\n'
            //             'Here\'s the error Facebook gave us: ${result.errorMessage}');
            //         break;
            //     }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  'https://img.icons8.com/color/48/000000/facebook.png'),
              SizedBox(
                width: 20,
              ),
              Text('Iniciar con Facebook')
            ],
          )),
    );
  }

  Widget isButtomTap() {
    if (isButtom) {
      return CircularProgressIndicator(
          backgroundColor: Color.fromRGBO(229, 62, 62, 1),
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
              'https://img.icons8.com/color/144/000000/google-logo.png'),
          SizedBox(
            width: 20,
          ),
          Text('Iniciar con Google')
        ],
      );
    }
  }

  static Future<bool> checkExist(String? docID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool exist = true;
    String id = '';
    String name = '';
    String email = '';
    try {
      await FirebaseFirestore.instance
          .collection('clients')
          .where('email', isEqualTo: docID)
          .get()
          .then((doc) async {
        if (doc.docs.length != 0) {
          exist = true;
          id = doc.docs[0].id;
          name = doc.docs[0]['names'];
          email = doc.docs[0]['email'];
        } else {
          exist = false;
        }
      });
      print(id);
      await prefs.setString('id_client', id);
      // await prefs.setString('name_client', name);
      await prefs.setStringList('data_client', [id, name, email]);
      return exist;
    } catch (e) {
      // If any error
      return false;
    }
  }
}
