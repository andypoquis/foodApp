import 'package:appfood/logic/logic_business.dart';
import 'package:appfood/model/business_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({key}) : super(key: key);

  @override
  _BusinessPageState createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  final myLogic = LogicBusiness();
  List<Business> newBusiness = [];
  double longitude = 0, latitude = 0;
  double distance = 0;
  bool isScanDistance = true;

  @override
  void initState() {
    super.initState();
    myLogic.getBusiness();
  }

  @override
  void dispose() {
    myLogic.cancel();
    super.dispose();
  }

  Future<void> showData() async {
    SharedPreferences prefrs = await SharedPreferences.getInstance();
    setState(() {
      if (prefrs.getDouble('latitude') != null) {
        latitude = prefrs.getDouble('latitude')!;
      }
      if (prefrs.getBool('isLocation') != null) {
        longitude = prefrs.getDouble('longitude')!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return ValueListenableBuilder<List<Business>>(
      valueListenable: myLogic.business,
      builder: (context, business, _) {
        if (business != null) {
          if (isScanDistance) {
            for (int i = 0; i < business.length; i++) {
              getDistance(business[i].geoPoint.latitude,
                  business[i].geoPoint.longitude, business[i]);
            }
            isScanDistance = false;
          }
        }

        return business != null
            ? Expanded(
                flex: 4,
                child: Container(
                  child: ListView.builder(
                      itemCount: newBusiness.length,
                      itemBuilder: (_, index) => GestureDetector(
                            onTap: () {},
                            child: Text('${newBusiness[index].address}'),
                          )),
                ),
              )
            : Expanded(
                flex: 4,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }

  Future<void> getDistance(double latitudeBusiness, double longitudeBusiness,
      Business business) async {
    // var _distanceInKm = await Geolocator().distanceBetween(
    //         latitude, longitude, latitudeBusiness, longitudeBusiness) /
    //     1000;
    // if (_distanceInKm <= 1) {
    //   newBusiness.add(business);
    // }
    // setState(() {
    //   distance = _distanceInKm;
    // });
  }

  void addBussinesItem() {}
}
