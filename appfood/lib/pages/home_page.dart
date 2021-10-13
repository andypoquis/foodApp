import 'package:appfood/pages/business_page/business_stream_page.dart';
import 'package:appfood/pages/location_page.dart';
import 'package:appfood/routes/routes.dart';
import 'package:appfood/shared/shared_preference.dart';
import 'package:appfood/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? adress = 'Ingresar ubicación';
  bool isLocation = false;

  @override
  void initState() {
    super.initState();
    showData();
  }

  Future<void> showData() async {
    // setState(() {
    //   if (prefrs.getString('address') != null) {
    //     adress = prefrs.getString('address')!;
    //   }
    //   if (prefrs.getBool('isLocation') != null) {
    //     isLocation = prefrs.getBool('isLocation')!;
    //   }
    // });

    final _addres = await SharedPreferencesData().getAddress();
    final _isLocation = await SharedPreferencesData().getisLocation();
    setState(() {
      if (_addres == null) {
        adress = 'Ingrese su ubicación';
      } else {
        adress = _addres;
      }
    });

    setState(() {
      if (_isLocation == null) {
        isLocation = false;
      } else {
        isLocation = _isLocation;
      }
    });

    // print('Addres: $adress');
  }

  @override
  Widget build(BuildContext context) {
    final _sizeScreen = MediaQuery.of(context).size;

    showData();

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              locationPage(_sizeScreen, context);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.room,
                                  color: Palette.kToDark,
                                ),
                                Text('$adress',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.grey[700])),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Buscar",
                                hintStyle: TextStyle(
                                  color: Colors.black.withAlpha(120),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (String keyword) {},
                            ),
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.black.withAlpha(120),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
            validateLocation(_sizeScreen),
          ],
        ),
      ),
    );
  }

  Widget validateLocation(_sizeScreen) {
    if (isLocation) {
      return BusinessStreamPage();
    } else {
      return Expanded(
        flex: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: SvgPicture.asset('assets/disablelocation.svg'),
            ),
            Text('No se ingreso ninguna ubicación'),
            SizedBox(
              height: 20,
            ),
            buttonLocation(_sizeScreen),
          ],
        ),
      );
    }
  }

  Widget buttonLocation(final _sizeScreen) {
    return Container(
      width: _sizeScreen.width * 0.75,
      height: 50,
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Palette.kToDark),
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
            Navigator.pushNamed(context, Routes.LOCATION);
          },
          child: Text('Ingresar ubicación')),
    );
  }

  void locationPage(final _sizeScreen, context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0))),
            child: Container(
              height: _sizeScreen.height * 0.95,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Agrega o escoge una dirección',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                  ),
                  SizedBox(height: 20),
                  locationContainer(),
                  SizedBox(
                    height: 20,
                  ),
                  listLocation(_sizeScreen),
                ],
              ),
            ),
          );
        });
  }

  Widget locationContainer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Ingresa su dirección",
              hintStyle: TextStyle(
                color: Colors.black.withAlpha(120),
              ),
              border: InputBorder.none,
            ),
            onChanged: (String keyword) {},
          ),
        ),
        Icon(
          Icons.room,
          color: Colors.black.withAlpha(120),
        )
      ],
    );
  }

  Widget listLocation(_sizeScreen) {
    return ListView(
      shrinkWrap: true,
      children: [
        GestureDetector(
          onTap: () {
            //googleMpasContainer(_sizeScreen, context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LocationPage(false, '', '', '')));
          },
          child: Row(
            children: [
              Icon(
                Icons.near_me,
                color: Palette.kToDark,
              ),
              Text('Activar ubicación actual'),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 2,
        ),
      ],
    );
  }

  Widget categoriesList() {
    return Container(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Card(
            child: Container(
              width: 100,
              child: Column(
                children: [
                  Image.network(
                      'https://img.icons8.com/color/96/000000/restaurant-.png'),
                  Text('Restaurante')
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              width: 100,
              child: Column(
                children: [
                  Image.network(
                      'https://img.icons8.com/color/96/000000/cake.png'),
                  Text('Pasteleria')
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              width: 100,
              child: Column(
                children: [
                  Image.network(
                      'https://img.icons8.com/color/96/000000/beer.png'),
                  Text('Licores')
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              width: 100,
              child: Column(
                children: [
                  Image.network(
                      'https://img.icons8.com/color/96/000000/pill.png'),
                  Text('Farmacia')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
