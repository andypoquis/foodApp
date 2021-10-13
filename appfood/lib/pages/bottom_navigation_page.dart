import 'package:appfood/pages/auth_page.dart';
import 'package:appfood/pages/home_page.dart';
import 'package:appfood/pages/menu_hamburger_page/menu_hamburger_page.dart';
import 'package:appfood/pages/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavigatorPage extends StatefulWidget {
  const BottomNavigatorPage({key}) : super(key: key);

  @override
  _BottomNavigatorPage createState() => _BottomNavigatorPage();
}

class _BottomNavigatorPage extends State<BottomNavigatorPage> {
  int _currentIndex = 0;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      showData();
      _currentIndex = 0;
    });
  }

  Future<void> showData() async {
    SharedPreferences prefrs = await SharedPreferences.getInstance();
    bool? newIsLogin = prefrs.getBool('isLogin');
    if (newIsLogin == null) {
      isLogin = false;
    } else {
      isLogin = prefrs.getBool('isLogin')!;
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    showData();
    List? pages;
    setState(() {
      pages = [HomePage(), OderPage(), menuItem3()];
    });

    //cambiar la barra de notificaciones
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));

    final _screenSize = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      drawer: MenuHamburger(),
      body: pages![_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'Pedidos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil')
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 2) {
              setState(() {
                if (isLogin) {
                  _scaffoldKey.currentState!.openDrawer();
                  _currentIndex = 0;
                } else if (isLogin == null || !isLogin) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AuthPage()));
                }
              });
            }
          });
        },
      ),
    ));
  }

  Widget menuItem3() {
    if (_currentIndex != 1) {
      setState(() {
        _currentIndex = 0;
      });
    }

    return Container();
  }
}
