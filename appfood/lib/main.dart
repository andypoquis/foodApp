import 'package:appfood/routes/pages.dart';
import 'package:appfood/routes/routes.dart';
import 'package:appfood/theme/theme_color.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:appfood/pages/login_page.dart';
// import 'package:appfood/pages/request_permission/request_permission_page.dart';
// import 'package:appfood/provider/app.dart';
// import 'package:appfood/provider/auth.dart';
// import 'package:appfood/shared/shared_preference.dart';
// import 'package:appfood/theme/theme_color.dart';

// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'helper/constants.dart';
// import 'model/login.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initialization;
//   runApp(MultiProvider(
//       providers: [
//         ChangeNotifierProvider.value(value: AppProvider()),
//         //ChangeNotifierProvider(create: (context) => DataModel()),
//         ChangeNotifierProvider.value(value: AuthProvider.init()),

//         // Provider(create: (context) => SomeOtherClass()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Chat room',
//         theme: ThemeData(
//           primarySwatch: Palette.kToDark,
//         ),
//         home: AppScreensController(),
//       )));
// }

// class AppScreensController extends StatefulWidget {
//   @override
//   _AppScreensControllerState createState() => _AppScreensControllerState();
// }

// class _AppScreensControllerState extends State<AppScreensController> {
//   bool isLogin = false;

//   @override
//   Widget build(BuildContext context) {
//     AuthProvider authProvider = Provider.of<AuthProvider>(context);

//     switch (authProvider.status) {
//       case Status.Uninitialized:
//         SharedPreferencesData sharedPreferencesData = SharedPreferencesData();
//         sharedPreferencesData.addIsLogin(false);
//         return RequestPermissionPage();

//       case Status.Authenticated:
//         SharedPreferencesData sharedPreferencesData = SharedPreferencesData();
//         sharedPreferencesData.addIsLogin(true);
//         return BottomNavigatorPage();

//       default:
//         SharedPreferencesData sharedPreferencesData = SharedPreferencesData();

//         sharedPreferencesData.addIsLogin(false);
//         if (isLogin) {
//           return BottomNavigatorPage();
//         } else {
//           return RequestPermissionPage();
//         }
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     showData();
//   }

//   Future<void> showData() async {
//     SharedPreferences prefrs = await SharedPreferences.getInstance();
//     setState(() {
//       bool newisLogin = prefrs.getBool('isLogin');
//       if (newisLogin == null) {
//         isLogin = false;
//       } else {
//         isLogin = true;
//       }
//     });
//   }
// }

//-----------------------------

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //token 01: 6C9C4DA8-A514-4A8A-BEAA-C7AD35041062
  //token 02: A184FDC2-8C6A-4FC5-B7F0-E0B2B02200B9
  await FirebaseAppCheck.instance
      .activate(webRecaptchaSiteKey: '6C9C4DA8-A514-4A8A-BEAA-C7AD35041062');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Palette.kToDark, primarySwatch: Palette.kToDark),
      debugShowCheckedModeBanner: false,
      title: 'MenuRapidito',
      //home: BottomNavigatorPage()
      initialRoute: Routes.SPLASH,
      routes: appRoutes(),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
