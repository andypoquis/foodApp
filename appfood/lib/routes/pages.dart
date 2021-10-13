import 'package:appfood/pages/bottom_navigation_page.dart';
import 'package:appfood/pages/home_page.dart';
import 'package:appfood/pages/location_page.dart';
import 'package:appfood/pages/request_permission/request_permission_page.dart';
import 'package:appfood/pages/splash/splash_page.dart';
import 'package:appfood/routes/routes.dart';
import 'package:flutter/widgets.dart';

Map<String, Widget Function(BuildContext)> appRoutes() {
  return {
    Routes.SPLASH: (_) => const SlpashPage(),
    Routes.PERMISSIONS: (_) => RequestPermissionPage(),
    Routes.HOME: (_) => const HomePage(),
    Routes.BOTTOM_NAVIGATOR: (_) => const BottomNavigatorPage(),
    Routes.LOCATION: (_) => LocationPage(false, '', '', ''),
  };
}
