import 'dart:io';

import 'package:appfood/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class StoreDetailPage extends StatefulWidget {
  final businessData;
  StoreDetailPage(this.businessData);

  @override
  _StoreDetailPageState createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  @override
  Widget build(BuildContext context) {
    final _sizeScreen = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: launchWhatsApp,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Color(0xfff1F2937),
              borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.only(bottom: 20),
          width: _sizeScreen.width * 0.55,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(child: Image.asset('assets/wsp.png')),
              SizedBox(
                width: 10,
              ),
              Text(
                'Contactar',
                style: TextStyle(
                    color: Palette.kToDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),

              //Container(child: Text('S/0.00'))
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('${widget.businessData['name']}',
                  style: TextStyle(
                    color: Palette.kToDark,
                    fontWeight: FontWeight.bold,
                  )),
              background: Image.network(
                '${widget.businessData['imageUrl']}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return cardProduct(
                  context,
                  _sizeScreen,
                  '${widget.businessData['menu'][index]['image']}',
                  '${widget.businessData['menu'][index]['name']}',
                  '${widget.businessData['menu'][index]['price']}');
            },
            childCount: widget.businessData['menu'].length,
            // SizedBox(
            //   height: 40,
            // ),
            // cardProduct(
            //     context,
            //     _sizeScreen,
            //     'https://img.vixdata.io/pd/jpg-large/es/sites/default/files/imj/elgranchef/g/gelatina-con-tutti-frutti.jpg',
            //     'Gelatina',
            //     '5.50'),
            // cardProduct(
            //     context,
            //     _sizeScreen,
            //     'https://d1uz88p17r663j.cloudfront.net/resized/13e670565e9d14c73420f8f4a068d186_07---Postre-3-leches_1200_600.jpg',
            //     'Tres Leches',
            //     '6.00'),
            // cardProduct(
            //     context,
            //     _sizeScreen,
            //     'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/delish-copycat-starbucks-caramel-frappuccino-pinterest-still001-1591821257.jpg?crop=1.00xw:0.669xh;0,0.157xh&resize=480:*',
            //     'Frappucino',
            //     '12.00'),
            // cardProduct(
            //     context,
            //     _sizeScreen,
            //     'https://www.elmundoeats.com/wp-content/uploads/2019/06/Partially-eaten-creme-caramel.jpg',
            //     'Flan',
            //     6),
            // cardProduct(
            //     context,
            //     _sizeScreen,
            //     'https://www.elmundoeats.com/wp-content/uploads/2019/06/Partially-eaten-creme-caramel.jpg',
            //     'Flan',
            //     6),
            // cardProduct(
            //     context,
            //     _sizeScreen,
            //     'https://www.elmundoeats.com/wp-content/uploads/2019/06/Partially-eaten-creme-caramel.jpg',
            //     'Flan',
            //     6),
            // SizedBox(
            //   height: 40,
            // )
          )),
        ],
      ),
    ));
  }

  openwhatsapp() async {
    var whatsapp = "+919144040888";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '${widget.businessData['contactNumbers'][0]['number']}',
      text:
          "✨Hola✨. *Vengo de MenuRapidito*, estoy interesado en realizar un pedido. 🤗",
    );
    // Convert the WhatsAppUnilink instance to a string.
    // Use either Dart's string interpolation or the toString() method.
    // The "launch" method is part of "url_launcher".
    await launch('$link');
  }

  void shooppingCart(final _sizeScreen, context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            // height: _sizeScreen.height * 0.95,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0))),
            child: Container(
              height: _sizeScreen.height * 0.45,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  ),
                  Expanded(child: Container()),
                  Container(
                    child: Text('Pedir'),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          );
        });
  }

  void detailPRoduct(final _sizeScreen, context) {
    int i = 0;
    int _value = 0;
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
                    'Frappucino',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: _sizeScreen.height * 0.65,
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Text('Fresa'),
                            Expanded(child: Container()),
                            Radio(
                                value: i,
                                groupValue: _value,
                                onChanged: (int? value) {})
                          ],
                        ),
                        Row(
                          children: [
                            Text('Chocolate'),
                            Expanded(child: Container()),
                            Radio(
                                value: i,
                                groupValue: _value,
                                onChanged: (int? value) {})
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget cardProduct(context, _sizeScreen, url, title, price) {
    return GestureDetector(
        onTap: () {
          //listOrders(_sizeScreen, context);
          detailPRoduct(_sizeScreen, context);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: Container(
              child: Row(
                children: [
                  Image.network(
                    '$url',
                    fit: BoxFit.cover,
                    width: _sizeScreen.width * 0.35,
                    height: 100,
                    loadingBuilder: (context, child, loadingProgress) {
                      return (loadingProgress == null)
                          ? child
                          : Container(
                              height: 100,
                              width: _sizeScreen.width * 0.35,
                              child: Image.asset(
                                'assets/load.gif',
                                fit: BoxFit.cover,
                              ),
                            );
                    },
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    width: _sizeScreen.width * 0.50,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$title',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 7.25,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'S/ $price',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
