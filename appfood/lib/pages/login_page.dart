import 'package:appfood/pages/bottom_navigation_page.dart';
import 'package:appfood/provider/app.dart';
import 'package:appfood/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({key}) : super(key: key);
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _sizeScreen = MediaQuery.of(context).size;
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final AppProvider appProvider = Provider.of<AppProvider>(context);
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
                        _sizeScreen, context, appProvider, authProvider),
                    SizedBox(
                      height: 20,
                    ),
                    buttonSignIn(_sizeScreen),
                    SizedBox(
                      height: 20,
                    ),
                    buttonGoogle(
                        _sizeScreen, appProvider, authProvider, context),
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

  Widget buttonLogin(final _sizeScreen, context, appProvider, authProvider) {
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
          onPressed: () {
            sigInPage(_sizeScreen, context, appProvider, authProvider);
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

  Widget buttonGoogle(final _sizeScreen, appProvider, authProvider, context) {
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
                return Colors.yellow
                    .withOpacity(0.12); // Defer to the widget's default.
              },
            ),
          ),
          onPressed: () async {
            appProvider.changeLoading();
            Map result = await authProvider.signInWithGoogle();
            bool success = result['success'];
            String message = result['message'];
            print(message);

            if (!success) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
              appProvider.changeLoading();
            } else {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLogin', true);
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: BottomNavigatorPage()));
              appProvider.changeLoading();

              BottomNavigatorPage();
              Navigator.pop(context);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  'https://img.icons8.com/color/144/000000/google-logo.png'),
              SizedBox(
                width: 20,
              ),
              Text('Iniciar con Google')
            ],
          )),
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
                return Colors.yellow
                    .withOpacity(0.12); // Defer to the widget's default.
              },
            ),
          ),
          onPressed: () async {
            final FacebookLoginResult result =
                await LoginPage.facebookSignIn.logIn(['email']);
            switch (result.status) {
              case FacebookLoginStatus.loggedIn:
                final FacebookAccessToken accessToken = result.accessToken;
                print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
                break;
              case FacebookLoginStatus.cancelledByUser:
                print('Login cancelled by the user.');
                break;
              case FacebookLoginStatus.error:
                print('Something went wrong with the login process.\n'
                    'Here\'s the error Facebook gave us: ${result.errorMessage}');
                break;
            }
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

  void sigInPage(_sizeScreen, context, appProvider, authProvider) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0))),
            height: _sizeScreen.height * 0.5,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  userTextField(_sizeScreen),
                  SizedBox(
                    height: 20,
                  ),
                  passwordTextField(_sizeScreen),
                  SizedBox(
                    height: 20,
                  ),
                  buttonAuth(_sizeScreen, context, appProvider, authProvider),
                ],
              ),
            ),
          );
        });
  }

  Widget userTextField(_sizeScreen) {
    return Container(
      color: Colors.grey[200],
      width: _sizeScreen.width * 0.75,
      child: TextFormField(
        controller: emailController,
        decoration: InputDecoration(
            icon: Icon(Icons.email),
            border: InputBorder.none,
            labelText: 'Correo Electronico'),
      ),
    );
  }

  Widget passwordTextField(_sizeScreen) {
    return Container(
      color: Colors.grey[200],
      width: _sizeScreen.width * 0.75,
      child: TextFormField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.lock),
            labelText: 'Contraseña'),
      ),
    );
  }

  Widget buttonAuth(final _sizeScreen, context, appProvider, authProvider) {
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
            appProvider.changeLoading();
            Map result = await authProvider.createUserEmail(
                emailController.text, passwordController.text);
            bool success = result['success'];
            String message = result['message'];
            print(message);

            if (!success) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
              appProvider.changeLoading();
            } else {
              appProvider.changeLoading();
              BottomNavigatorPage();
            }
          },
          child: Text('Iniciar Sesion')),
    );
  }
}
