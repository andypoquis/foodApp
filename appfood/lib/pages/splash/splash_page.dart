import 'package:appfood/pages/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SlpashPage extends StatefulWidget {
  const SlpashPage({key}) : super(key: key);

  @override
  _SlpashPageState createState() => _SlpashPageState();
}

class _SlpashPageState extends State<SlpashPage> {
  final _controller = SplashController(Permission.locationWhenInUse);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _controller.checPermission();
    });
    _controller.addListener(() {
      if (_controller.ruteName != null) {
        Navigator.pushReplacementNamed(context, _controller.ruteName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
