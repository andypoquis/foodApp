import 'package:flutter/material.dart';

class SigInPage extends StatelessWidget {
  const SigInPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  width: _sizeScreen.width,
                  color: Colors.blue,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buttonLogin(_sizeScreen),
                      buttonFacebook(_sizeScreen),
                      buttonGoogle(_sizeScreen)
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }

  Widget buttonLogin(final _sizeScreen) {
    return Container(
      width: _sizeScreen.width * 0.6,
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
                return Colors.yellow.withOpacity(0.12);

                // Defer to the widget's default.
              },
            ),
          ),
          onPressed: () {},
          child: Text('Iniciar Sesion')),
    );
  }

  Widget buttonSignIn(final _sizeScreen) {
    return Container(
      width: _sizeScreen.width * 0.6,
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

  Widget buttonGoogle(final _sizeScreen) {
    return Container(
      width: _sizeScreen.width * 0.6,
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

  Widget buttonFacebook(final _sizeScreen) {
    return Container(
      width: _sizeScreen.width * 0.6,
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
}
