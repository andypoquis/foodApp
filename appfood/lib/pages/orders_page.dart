import 'package:appfood/theme/theme_color.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class OderPage extends StatefulWidget {
  const OderPage({key}) : super(key: key);

  @override
  _OderPageState createState() => _OderPageState();
}

class _OderPageState extends State<OderPage> {
  String? adress = '';

  Future<void> showData() async {
    SharedPreferences prefrs = await SharedPreferences.getInstance();
    setState(() {
      adress = prefrs.getString('address');
    });
  }

  @override
  void initState() {
    showData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _sizeScreen = MediaQuery.of(context).size;
    return Container(
      width: _sizeScreen.width,
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
                    // Row(
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         //locationPage(_sizeScreen, context);
                    //       },
                    //       child: Row(
                    //         children: [
                    //           Icon(
                    //             Icons.room,
                    //             color: Palette.kToDark,
                    //           ),
                    //           Text('$adress',
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 15,
                    //                   color: Colors.grey[700])),
                    //           Icon(Icons.arrow_drop_down),
                    //         ],
                    //       ),
                    //     )
                    //   ],
                    // ),
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
          Expanded(
            flex: 4,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: cardOrders(
                      context,
                      _sizeScreen,
                      'https://media-cdn.tripadvisor.com/media/photo-s/16/5a/9f/9d/pasteleria-artesanal.jpg',
                      'Pastelería las Delicias'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void locationPage(final _sizeScreen, context) {
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
                  listLocation(),
                ],
              ),
            ),
          );
        });
  }

  void listOrders(final _sizeScreen, context) {
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
            child: Container(
              height: _sizeScreen.height * 0.95,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pasteleria las Delicias',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Gelatina'),
                      Expanded(child: Container()),
                      Text('S/ 5.50')
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Frappuccino'),
                      Expanded(child: Container()),
                      Text('S/ 12.00')
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Tres Leches'),
                      Expanded(child: Container()),
                      Text('S/ 6.00')
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Total'),
                      Expanded(child: Container()),
                      Text('S/23.50')
                    ],
                  )
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

  Widget listLocation() {
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            Icon(
              Icons.near_me,
              color: Palette.kToDark,
            ),
            Text('Activar ubicación actual'),
          ],
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

  Widget cardOrders(context, _sizeScreen, url, title) {
    return GestureDetector(
        onTap: () {
          listOrders(_sizeScreen, context);
        },
        child: Card(
          child: Container(
            child: Row(
              children: [
                Image.network(
                  '$url',
                  fit: BoxFit.cover,
                  width: _sizeScreen.width * 0.35,
                  height: 160,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: _sizeScreen.width * 0.50,
                  height: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$title',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 7.25,
                      ),
                      Text(
                        'Restaurante, cevichería',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('13/08/2021 8.00 pm'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('S/ 23.50'),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        color: Palette.kToDark,
                        child: Text('Entregado'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
