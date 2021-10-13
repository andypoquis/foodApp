import 'package:appfood/pages/location/location_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationPage extends StatefulWidget {
  //const LocationPage({key}) : super(key: key);
  LocationPage(
      this.isBusiness, this.nameBussines, this.dataRubrics, this.nameRubric);
  final String nameBussines;
  final String dataRubrics;
  final String nameRubric;
  final bool isBusiness;

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  TextEditingController textControllerAddress = TextEditingController();

  bool isButtom = false;

  @override
  Widget build(BuildContext context) {
    CollectionReference bussiness =
        FirebaseFirestore.instance.collection('business');
    //------------------------------------------------------------------

    final _sizeScreen = MediaQuery.of(context).size;

    return ChangeNotifierProvider<LocationController>(
      create: (_) {
        final controller = LocationController();
        return controller;
      },
      child: Container(
          height: _sizeScreen.height * 0.55,
          child: pageCompletLoad(_sizeScreen, context, bussiness)),
    );
  }

  Widget pageCompletLoad(_sizeScreen, context, bussiness) {
    return Selector<LocationController, bool>(
      selector: (_, controller) => controller.loading,
      builder: (context, loading, loadingWidget) {
        if (loading) {
          return loadingWidget!;
        }
        return SafeArea(
          child: Scaffold(
              body: Consumer<LocationController>(
            builder: (_, controller, gpsMessageWidget) {
              if (!controller.gpsEnabled) {
                return gpsMessageWidget!;
              }

              final initalPosition = LatLng(
                  controller.initialPosition!.latitude,
                  controller.initialPosition!.longitude);

              final address = controller.initialAddresString!;

              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirmar tu dirección',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]),
                    ),
                    SizedBox(height: 20),
                    Container(
                        height: _sizeScreen.height * 0.25,
                        width: _sizeScreen.width * 1,
                        child: GoogleMap(
                          onMapCreated: controller.onMapCreated,
                          initialCameraPosition:
                              CameraPosition(target: initalPosition, zoom: 18),
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          markers: controller.markers,
                          onTap: controller.onTap,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    locationTextField(_sizeScreen, address),
                    SizedBox(
                      height: 15,
                    ),
                    // cityTextField(_sizeScreen),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    referenceTextField(_sizeScreen),
                    SizedBox(
                      height: 15,
                    ),
                    //buttonSaveLocation(_sizeScreen, controller.initialPosition!)

                    isButtonSelection(controller.initialPosition!, _sizeScreen),
                  ],
                ),
              );
            },
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Active la ubicación de su dispositivo'),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      final controller = context.read<LocationController>();
                      controller.turnOnGps();
                    },
                    child: Text('Encienda su GPS'))
              ],
            )),
          )),
        );
      },
      child: Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget locationTextField(_sizeScreen, String? address) {
    textControllerAddress.text = address!;

    return Container(
      color: Colors.grey[200],
      //width: _sizeScreen.width * 0.75,
      child: TextFormField(
        controller: textControllerAddress,
        onChanged: (value) {
          value = address;
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            //icon: Icon(Icons.lock),
            labelText: '  Dirección'),
      ),
    );
  }

  Widget cityTextField(_sizeScreen) {
    return Container(
      color: Colors.grey[200],
      //width: _sizeScreen.width * 0.75,
      child: TextFormField(
        //controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
            border: InputBorder.none,
            //icon: Icon(Icons.lock),
            labelText: '  Dirección'),
      ),
    );
  }

  Widget referenceTextField(_sizeScreen) {
    return Container(
      color: Colors.grey[200],
      //width: _sizeScreen.width * 0.75,
      child: TextFormField(
        //controller: passwordController,

        decoration: InputDecoration(
            border: InputBorder.none,
            //icon: Icon(Icons.lock),
            labelText: '  Agrega una referencia'),
      ),
    );
  }

  Widget buttonSaveLocation(final _sizeScreen, Position? position) {
    return Container(
      width: _sizeScreen.width,
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
                return Colors.yellow
                    .withOpacity(0.12); // Defer to the widget's default.
              },
            ),
          ),
          onPressed: () async {
            setState(() {
              isButtom = true;
            });
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('address', textControllerAddress.text);
            await prefs.setBool('isLocation', true);

            await prefs.setDouble('latitude', position!.latitude);
            await prefs.setDouble('longitude', position.longitude);
            Future.delayed(const Duration(milliseconds: 3000), () {
              setState(() {
                Navigator.pop(context, true);
              });
            });
          },
          child: isButtomTap()),
    );
  }

  Widget isButtomTap() {
    if (isButtom) {
      return CircularProgressIndicator(
          backgroundColor: Color.fromRGBO(229, 62, 62, 1),
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    } else {
      return textButton();
    }
  }

  Widget isButtonSelection(Position position, _sizeScreen) {
    return buttonSaveLocation(_sizeScreen, position);
  }

  Widget textButton() {
    return widget.isBusiness
        ? Text('Agregar negocio')
        : Text('Guardar direccion');
  }
}
