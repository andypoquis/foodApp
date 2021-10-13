import 'package:appfood/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends ChangeNotifier {
  final Permission _locationPermission;
  late String _routeName;
  String get ruteName => _routeName;

  SplashController(this._locationPermission);

  Future<void> checPermission() async {
    final isGrranted = await this._locationPermission.isGranted;
    _routeName = isGrranted ? Routes.BOTTOM_NAVIGATOR : Routes.PERMISSIONS;
    notifyListeners();
  }
}
