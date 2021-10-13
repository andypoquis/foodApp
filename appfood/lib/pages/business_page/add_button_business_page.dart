import 'dart:io';

import 'package:appfood/model/business_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddButtonBusiness extends StatefulWidget {
  final String name;
  final String address;
  final Position position;
  final String dataRubrics;
  final String nameRubric;
  final String pathRute;
  //const AddButtonBusiness({Key? key}) : super(key: key);
  AddButtonBusiness(this.name, this.address, this.position, this.dataRubrics,
      this.nameRubric, this.pathRute);

  @override
  _AddButtonBusinessState createState() => _AddButtonBusinessState();
}

class _AddButtonBusinessState extends State<AddButtonBusiness> {
  bool isButtom = false;
  String url = '';
  String idBusiness = '';
  bool isComplete = false;
  @override
  Widget build(BuildContext context) {
    final _sizeScreen = MediaQuery.of(context).size;
    CollectionReference business =
        FirebaseFirestore.instance.collection('business');

    // ignore: unused_element
    Future<void> addBussines() async {
      setState(() {
        isButtom = true;
      });
      Future.delayed(const Duration(milliseconds: 5000), () {
        setState(() {
          Navigator.pop(context, true);
          Navigator.pop(context, true);
        });
      });

      final prefs = await SharedPreferences.getInstance();

      // dowloandURL =
      //     await (await FirebaseApi.uploadFile(urlImage, File(widget.pathRute)))!
      //         .ref
      //         .getDownloadURL();
      // print('Esto es el url: $dowloandURL');
      if (url == '') {
        business
            .add(Business(
                    address: widget.address,
                    attentionHours: {},
                    categories: [],
                    clientId: prefs.getStringList('data_client')![0],
                    contactNumber: [],
                    createdAt: DateTime.now(),
                    geoPoint: GeoPoint(
                        widget.position.latitude, widget.position.longitude),
                    imageUrl: '',
                    menu: [],
                    name: widget.name,
                    plan: {'id': '63xZJBAvHOMcvCMgxLMz', 'name': 'Gratuito'},
                    rubic: widget.nameRubric,
                    rubicId: widget.dataRubrics,
                    updateAt: DateTime.now())
                .toJson())
            .then((value) async {
          if (value.id != '') {
            await uploadFile(widget.pathRute, value.id);
          }
        }).catchError((error) => print('errorr'));
      }
    }

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
          onPressed: addBussines,
          child: isButtomTap()),
    );
  }

  Future<void> uploadFile(String filePath, String id) async {
    File file = File(filePath);
    CollectionReference business =
        FirebaseFirestore.instance.collection('business');
    print(id);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('business/${id}/negocio_image.jpg')
          .putFile(file);
      await firebase_storage.FirebaseStorage.instance
          .ref('business/${id}/negocio_image.jpg')
          .getDownloadURL()
          .then((value) {
        setState(() {
          isComplete = true;
        });

        business
            .doc(id)
            .update({'imageUrl': value})
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
      });
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Widget isButtomTap() {
    if (isButtom) {
      return CircularProgressIndicator(
          backgroundColor: Color.fromRGBO(229, 62, 62, 1),
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    } else {
      return Text('Agregar producto', style: TextStyle());
    }
  }
}
