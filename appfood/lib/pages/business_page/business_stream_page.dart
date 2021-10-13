import 'package:appfood/pages/store_detail_page.dart';
import 'package:appfood/theme/theme_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessStreamPage extends StatefulWidget {
  BusinessStreamPage({Key? key}) : super(key: key);

  @override
  _BusinessStreamPageState createState() => _BusinessStreamPageState();
}

class _BusinessStreamPageState extends State<BusinessStreamPage> {
  double? latitude;
  double? longitude;
  double distance = 0;
  List newBusiness = [];
  int itemsCount = 0;
  bool isScanDistance = true;
  int lengthBusiness = 0;
  List<bool> isBusiness = [];
  bool isLoadBusiness = false;
  bool isBusinessLoad = false;
  List<int> indexBusiness = [];
  int countBusiness = 0;
  List<QueryDocumentSnapshot> dataBusiness = [];
  final Stream<QuerySnapshot> _businessStream =
      FirebaseFirestore.instance.collection('business').snapshots();

  @override
  void dispose() {
    isBusiness = [];
    isLoadBusiness = false;
    isBusinessLoad = false;
    dataBusiness = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _sizeScreen = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: _businessStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('A ocurrido un error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // // for (int i = 0; i < snapshot.data!.docs.length; i++) {
          //   double distanceInMeters = Geolocator.distanceBetween(
          //       snapshot.data!.docs[i]['geopoint'].latitude,
          //       snapshot.data!.docs[i]['geopoint'].latitude,
          //       52.3546274,
          //       4.8285838);
          if (itemsCount != snapshot.data!.docs.length) {
            itemsCount = snapshot.data!.docs.length;
            isScanDistance = true;
            isBusiness = [];
            dataBusiness = [];
            indexBusiness = [];
          }

          if (isScanDistance) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              getDistance(
                  snapshot.data!.docs[i]['geopoint'].latitude,
                  snapshot.data!.docs[i]['geopoint'].longitude,
                  snapshot.data!.docs,
                  i,
                  snapshot.data!.docs.length);
            }
            isScanDistance = false;
          }

          if (isBusinessLoad) {
            for (int i = 0; i < indexBusiness.length; i++) {
              dataBusiness[i] = snapshot.data!.docs[indexBusiness[i]];
            }
          }

          // print('Data uno: ${newBusiness[0]['name']}');
          Future<Null> _refreshBusiness() async {}

          return Expanded(
            flex: 4,
            child: RefreshIndicator(
              onRefresh: _refreshBusiness,
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  categoriesList(),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: dataBusiness.length,
                        itemBuilder: (context, index) => GestureDetector(
                              child: cardStore(
                                _sizeScreen,
                                dataBusiness[index]['name'],
                                dataBusiness[index]['imageUrl'],
                                context,
                                dataBusiness[index],
                                // '${newBusiness[index]['name']}',
                                // '${newBusiness[index]['imageUrl']}',
                                // context,
                                // newBusiness[index],
                                index,
                              ),
                            )),
                  ),
                ],
              ),
            ),
          );
        });
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

  Widget loadBusiness(
    _sizeScreen,
    String title,
    String url,
    context,
    businessData,
    int index,
  ) {
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        isLoadBusiness = true;
      });
    });
    return (!isLoadBusiness)
        ? Container()
        : cardStore(_sizeScreen, title, url, context, businessData, index);
  }

  Widget cardStore(
    _sizeScreen,
    String title,
    String url,
    context,
    businessData,
    int index,
  ) {
    if (1 == 1) {
      return GestureDetector(
        onTap: () {
          // print('Longitud ${dataBusiness[0]['name']}');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StoreDetailPage(businessData)));

          print('tamaño del vector: ${isBusiness.length}');
        },
        child: Card(
          child: Container(
            child: Row(
              children: [
                containerImageProduct(url, _sizeScreen),
                // Image.network(
                //   '$url',
                //   fit: BoxFit.cover,
                //   width: _sizeScreen.width * 0.35,
                //   height: 150,
                // ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    height: 150,
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
                        Container(
                          color: Palette.kToDark,
                          child: Row(
                            children: [
                              Icon(Icons.credit_card),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Se acepta tarjeta')
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('15 - 20 min'),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.delivery_dining,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('S/2.00')
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget containerImageProduct(String url, _sizeScreen) {
    return (url == null || url == '')
        ? Container()
        : Image.network(
            '$url',
            fit: BoxFit.cover,
            width: _sizeScreen.width * 0.35,
            height: 150,
            loadingBuilder: (context, child, loadingProgress) {
              return (loadingProgress == null)
                  ? child
                  : Container(
                      height: 150,
                      width: _sizeScreen.width * 0.35,
                      child: Image.asset(
                        'assets/load.gif',
                        fit: BoxFit.cover,
                      ),
                    );
            },
          );
  }

  Future<void> getDistance(double latitudeBusiness, double longitudeBusiness,
      List<QueryDocumentSnapshot> snapshot, int i, int maxlength) async {
    final prefs = await SharedPreferences.getInstance();
    var _distanceInKm = Geolocator.distanceBetween(
            latitudeBusiness,
            longitudeBusiness,
            prefs.getDouble('latitude')!,
            prefs.getDouble('longitude')!) /
        1000;

    if (_distanceInKm <= 3 && isBusiness.length <= maxlength) {
      setState(() {
        isBusiness.add(true);
        dataBusiness.add(snapshot[i]);
        indexBusiness.add(i);
        countBusiness++;
      });
    } else if (isBusiness.length <= maxlength && _distanceInKm > 3) {
      setState(() {
        isBusiness.add(false);
        countBusiness++;
      });
    }
    if (isBusiness.length == maxlength) {
      setState(() {
        isBusinessLoad = true;
      });
    }
    print("Maxima longitud permitida: $maxlength");
    print("Longitud incrementda: ${countBusiness}");
    //print('La distancia es: $_distanceInKm');
    setState(() {
      distance = _distanceInKm;
    });
  }
}
