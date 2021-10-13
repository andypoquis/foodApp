import 'dart:async';

import 'package:appfood/pages/request_permission/request_permission_controller.dart';
import 'package:appfood/routes/routes.dart';
import 'package:appfood/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermissionPage extends StatefulWidget {
  RequestPermissionPage({key}) : super(key: key);

  @override
  _RequestPermissionPageState createState() => _RequestPermissionPageState();
}

class _RequestPermissionPageState extends State<RequestPermissionPage>
    with WidgetsBindingObserver {
  final _controller =
      RequestPermisssionController(Permission.locationWhenInUse);

  late StreamSubscription _subcription;
  bool _fromSettings = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _subcription = _controller.onStatusChanged.listen((status) {
      switch (status) {
        case PermissionStatus.granted:
          _goToHome();
          break;
        case PermissionStatus.permanentlyDenied:
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text('Permisos'),
                    content: Text(
                        'Permitir que la aplicación acceda a la ubicación'),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            _fromSettings = await openAppSettings();
                          },
                          child: Text('Abrir configuración')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancelar'))
                    ],
                  ));
          break;
        default:
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && _fromSettings) {
      final status = await _controller.check();
      if (status == PermissionStatus.granted) _goToHome();
    }
    _fromSettings = false;
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _controller.dispose();
    _subcription.cancel();
    super.dispose();
  }

  void _goToHome() {
    Navigator.pushReplacementNamed(context, Routes.BOTTOM_NAVIGATOR);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.kToDark,
      child: Container(
        color: Palette.kToDark,
        child: ElevatedButton(
          child: Text('Menu Rapidito'),
          onPressed: () {
            _controller.request();
          },
        ),
      ),
    );
  }
}
