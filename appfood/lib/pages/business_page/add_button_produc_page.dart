import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class AddButtonProduct extends StatefulWidget {
  final String idBusiness,
      nameProduct,
      price,
      category,
      url,
      nameRubric,
      nameBusiness;
  AddButtonProduct(this.idBusiness, this.nameProduct, this.price, this.category,
      this.url, this.nameRubric, this.nameBusiness);

  @override
  _AddButtonProductState createState() => _AddButtonProductState();
}

class _AddButtonProductState extends State<AddButtonProduct> {
  bool isButtom = false;
  String url = '';
  @override
  Widget build(BuildContext context) {
    final _sizeScreen = MediaQuery.of(context).size;

    //Agregar image

    Future<void> addBussines() async {
      setState(() {
        isButtom = true;
      });

      await uploadFile(widget.url);

      if (url != '') {
        CollectionReference business =
            FirebaseFirestore.instance.collection('business');
        List<Map<String, dynamic>> dataConctac = [
          {
            'category': widget.category,
            'image': url,
            'name': widget.nameProduct,
            'price': widget.price,
          }
        ];
        business
            .doc(widget.idBusiness)
            .update({'menu': FieldValue.arrayUnion(dataConctac)})
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
      }

      Future.delayed(const Duration(milliseconds: 3500), () {
        setState(() {
          url = '';

          Navigator.pop(context, true);
        });
      });
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

  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);
    var uuid = Uuid();
    String nameProduct = uuid.v4();
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(
              'business/${widget.nameRubric}/${widget.nameBusiness}/products/$nameProduct')
          .putFile(file);
      await firebase_storage.FirebaseStorage.instance
          .ref(
              'business/${widget.nameRubric}/${widget.nameBusiness}/products/$nameProduct')
          .getDownloadURL()
          .then((value) {
        setState(() {
          url = value;
        });
      });
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  void addProduct() {
    CollectionReference business =
        FirebaseFirestore.instance.collection('business');
    List<Map<String, dynamic>> dataConctac = [
      {
        'category': widget.category,
        'image': url,
        'name': widget.nameProduct,
        'price': widget.price,
      }
    ];
    business
        .doc(widget.idBusiness)
        .update({'menu': FieldValue.arrayUnion(dataConctac)})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Widget isButtomTap() {
    if (isButtom) {
      return CircularProgressIndicator(
          backgroundColor: Color.fromRGBO(229, 62, 62, 1),
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    } else {
      return Text('Agregar negocio', style: TextStyle());
    }
  }
}
