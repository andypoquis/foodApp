// import 'package:appfood/model/business_model.dart';
// import 'package:appfood/model/rubics.dart';
// import 'package:appfood/pages/location_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import '../camara_page.dart';

// class AddBusinessPage extends StatefulWidget {
//   const AddBusinessPage({Key? key, this.business}) : super(key: key);
//   final Business? business;

//   @override
//   _AddBusinessPageState createState() => _AddBusinessPageState();
// }

// class _AddBusinessPageState extends State<AddBusinessPage> {
//   //Controller Text
//   List<String> dataClient = ['', ''];
//   TextEditingController textControllerName = TextEditingController();
//   TextEditingController textControllerAddress = TextEditingController();
//   TextEditingController textControllercontactNumbers = TextEditingController();
//   TextEditingController textControllerRubricsName = TextEditingController();
//   TextEditingController textControllerRubircId = TextEditingController();
//   GeoPoint newGeoPoint = GeoPoint(-6.5121, -76.3690);
//   bool isInitComponet = true;
//   // late BussinesDetailLogic businessLogic;

//   bool isButton = false;
//   List<String> itemRubics = [''];
//   XFile? imageFile = null;
//   Map<String, String> dataRubrics = {};
//   final moviesRef =
//       FirebaseFirestore.instance.collection('rubrics').withConverter<Rubics>(
//             fromFirestore: (snapshot, _) => Rubics.fromJson(snapshot.data()!),
//             toFirestore: (rubics, _) => rubics.toJson(),
//           );

//   Future<void> main() async {
//     // Obtain science-fiction movies

//     List<QueryDocumentSnapshot<Rubics>> rubicsData =
//         await moviesRef.get().then((snapshot) => snapshot.docs);

//     for (int i = 0; i < rubicsData.length; i++) {
//       itemRubics.add(rubicsData[i]['label']);

//       dataRubrics[rubicsData[i]['label']] = rubicsData[i].id;
//     }

//     itemRubics.remove('');
//   }

//   @override
//   void initState() {
//     super.initState();

//     main();
//   }

//   String idRubric = '';
//   String? _chosenValue;
//   String itemRubricsValue = '';

//   CameraWidgetState camera = CameraWidgetState();

//   @override
//   Widget build(BuildContext context) {
//     // main();
//     // showData();

//     final _sizeScreen = MediaQuery.of(context).size;

//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Agregar negocio'),
//         ),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             children: [
//               initWidget(_sizeScreen),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 color: Colors.grey[200],
//                 width: _sizeScreen.width,
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.inventory_2_outlined,
//                       color: Colors.grey[600],
//                     ),
//                     SizedBox(
//                       width: 12.5,
//                     ),
//                     DropdownButton<String>(
//                       value: _chosenValue,
//                       //elevation: 5,
//                       style: TextStyle(color: Colors.black),

//                       items: itemRubics
//                           .map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       hint: Text(
//                         "Seleccionar el rubro de tu negocio",
//                         style: TextStyle(
//                             color: Colors.grey[700],
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       onChanged: (String? value) {
//                         setState(() {
//                           _chosenValue = value;
//                           textControllerRubricsName.text = value!;
//                           textControllerRubircId.text = dataRubrics[value]!;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               LocationPage(true, textControllerName.text,
//                   textControllerRubircId.text, textControllerRubricsName.text),
//               SizedBox(height: 20),
//               CameraWidget(),
//             ],
//           ),
//         ));
//   }

//   Widget nameTextFiel(_sizeScreen) {
//     return Container(
//       color: Colors.grey[200],
//       width: _sizeScreen.width,
//       child: TextFormField(
//         controller: textControllerName,
//         decoration: InputDecoration(
//             icon: Icon(Icons.store_outlined),
//             border: InputBorder.none,
//             labelText: 'Negocio: '),
//       ),
//     );
//   }

//   Widget nameAddress(_sizeScreen) {
//     return Container(
//       color: Colors.grey[200],
//       width: _sizeScreen.width,
//       child: TextFormField(
//         controller: textControllerAddress,
//         decoration: InputDecoration(
//             icon: Icon(Icons.location_on_outlined),
//             border: InputBorder.none,
//             labelText: 'Direccion: '),
//       ),
//     );
//   }

//   Widget isButtomTap() {
//     if (isButton) {
//       return CircularProgressIndicator(
//           backgroundColor: Color.fromRGBO(229, 62, 62, 1),
//           valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
//     } else {
//       return Text('Guardar',
//           style: TextStyle(
//             color: Colors.white,
//           ));
//     }
//   }
// }

//--------------- Editado---------------------------------
import 'package:appfood/model/business_model.dart';
import 'package:appfood/model/rubics.dart';
import 'package:appfood/pages/location/location_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../camara_page.dart';

class AddBusinessPage extends StatefulWidget {
  const AddBusinessPage({Key? key, this.business}) : super(key: key);
  final Business? business;

  @override
  _AddBusinessPageState createState() => _AddBusinessPageState();
}

class _AddBusinessPageState extends State<AddBusinessPage> {
  //Controller Text
  List<String> dataClient = ['', ''];
  TextEditingController textControllerName = TextEditingController();
  TextEditingController textControllerAddress = TextEditingController();
  TextEditingController textControllercontactNumbers = TextEditingController();
  TextEditingController textControllerRubricsName = TextEditingController();
  TextEditingController textControllerRubircId = TextEditingController();
  GeoPoint newGeoPoint = GeoPoint(-6.5121, -76.3690);
  bool isInitComponet = true;
  // late BussinesDetailLogic businessLogic;

  bool isButtom = false;

  bool isButton = false;
  List<String> itemRubics = [''];
  XFile? imageFile = null;
  Map<String, String> dataRubrics = {};
  final moviesRef =
      FirebaseFirestore.instance.collection('rubrics').withConverter<Rubics>(
            fromFirestore: (snapshot, _) => Rubics.fromJson(snapshot.data()!),
            toFirestore: (rubics, _) => rubics.toJson(),
          );

  Future<void> main() async {
    // Obtain science-fiction movies

    List<QueryDocumentSnapshot<Rubics>> rubicsData =
        await moviesRef.get().then((snapshot) => snapshot.docs);

    for (int i = 0; i < rubicsData.length; i++) {
      itemRubics.add(rubicsData[i]['label']);

      dataRubrics[rubicsData[i]['label']] = rubicsData[i].id;
    }

    itemRubics.remove('');
  }

  @override
  void initState() {
    super.initState();

    main();
  }

  String idRubric = '';
  String? _chosenValue;
  String itemRubricsValue = '';

  @override
  Widget build(BuildContext context) {
    // main();
    // showData();
    CollectionReference bussiness =
        FirebaseFirestore.instance.collection('business');
    final _sizeScreen = MediaQuery.of(context).size;

    return ChangeNotifierProvider<LocationController>(
        create: (_) {
          final controller = LocationController();
          return controller;
        },
        child: pageCompletLoad(_sizeScreen, context, bussiness));
  }

  Widget nameTextFiel(_sizeScreen) {
    return Container(
      color: Colors.grey[200],
      width: _sizeScreen.width,
      child: TextFormField(
        controller: textControllerName,
        decoration: InputDecoration(
            icon: Icon(Icons.store_outlined),
            border: InputBorder.none,
            labelText: 'Negocio: '),
      ),
    );
  }

  Widget initWidget(_sizeScreen) {
    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        isInitComponet = false;
      });
    });

    if (isInitComponet) {
      return Container();
    } else {
      return nameTextFiel(_sizeScreen);
    }
  }

  Widget nameAddress(_sizeScreen) {
    return Container(
      color: Colors.grey[200],
      width: _sizeScreen.width,
      child: TextFormField(
        controller: textControllerAddress,
        decoration: InputDecoration(
            icon: Icon(Icons.location_on_outlined),
            border: InputBorder.none,
            labelText: 'Direccion: '),
      ),
    );
  }

  Widget isButtomTap() {
    if (isButton) {
      return CircularProgressIndicator(
          backgroundColor: Color.fromRGBO(229, 62, 62, 1),
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    } else {
      return Text('Guardar',
          style: TextStyle(
            color: Colors.white,
          ));
    }
  }

  //Location
  Widget pageCompletLoad(_sizeScreen, context, bussiness) {
    return Selector<LocationController, bool>(
      selector: (_, controller) => controller.loading,
      builder: (context, loading, loadingWidget) {
        if (loading) {
          return loadingWidget!;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Agregar negocio'),
          ),
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      nameTextFiel(_sizeScreen),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        color: Colors.grey[200],
                        width: _sizeScreen.width,
                        child: Row(
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 12.5,
                            ),
                            DropdownButton<String>(
                              value: _chosenValue,
                              //elevation: 5,
                              style: TextStyle(color: Colors.black),

                              items: itemRubics.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: Text(
                                "Seleccionar el rubro de tu negocio",
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  _chosenValue = value;
                                  textControllerRubricsName.text = value!;
                                  textControllerRubircId.text =
                                      dataRubrics[value]!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
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
                            initialCameraPosition: CameraPosition(
                                target: initalPosition, zoom: 18),
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

                      CameraWidget(
                          false,
                          false,
                          textControllerName.text,
                          textControllerAddress.text,
                          textControllerRubircId.text,
                          '',
                          textControllerRubricsName.text,
                          '',
                          '',
                          '',
                          controller.initialPosition!),
                      SizedBox(
                        height: 20,
                      ),
                      //buttonSaveLocation(_sizeScreen, controller.initialPosition!)

                      // isButtonSelection(controller.initialPosition!, _sizeScreen),
                    ],
                  ),
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
          ),
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

  // Widget isButtomTap() {
  //   if (isButtom) {
  //     return CircularProgressIndicator(
  //         backgroundColor: Color.fromRGBO(229, 62, 62, 1),
  //         valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
  //   } else {
  //     return textButton();
  //   }
  // }

  // Widget isButtonSelection(Position position, _sizeScreen) {
  //   return widget.isBusiness
  //       ? AddButtonBusiness(widget.nameBussines, textControllerAddress.text,
  //           position, '', widget.dataRubrics, widget.nameRubric)
  //       : buttonSaveLocation(_sizeScreen, position);
  // }

  // Widget textButton() {
  //   return widget.isBusiness
  //       ? Text('Agregar negocio')
  //       : Text('Guardar direccion');
  // }
}
