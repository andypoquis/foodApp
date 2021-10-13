import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class UpdateButtonBussines extends StatefulWidget {
  final String idBusiness, nameBussines, pathRute, nameRubric;
  UpdateButtonBussines(
      this.idBusiness, this.nameBussines, this.nameRubric, this.pathRute);
  @override
  State<UpdateButtonBussines> createState() => _UpdateButtonBussinesState();
}

class _UpdateButtonBussinesState extends State<UpdateButtonBussines> {
  bool isButtom = false;
  String url = '';
  @override
  Widget build(BuildContext context) {
    final _sizeScreen = MediaQuery.of(context).size;
    Future<void> addBussines() async {
      setState(() {
        isButtom = true;
      });

      await uploadFile(widget.pathRute);
      CollectionReference business =
          FirebaseFirestore.instance.collection('business');
      if (url != '') {
        business
            .doc(widget.idBusiness)
            .update({'imageUrl': url})
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
      } else if (widget.nameBussines != '') {
        business
            .doc(widget.idBusiness)
            .update({'name': widget.nameBussines})
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
      }

      Future.delayed(const Duration(milliseconds: 500), () {
        url = '';
        setState(() {
          Navigator.pop(context, true);
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

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('business/${widget.idBusiness}/negocio_image.jpg')
          .putFile(file);
      await firebase_storage.FirebaseStorage.instance
          .ref('business/${widget.idBusiness}/negocio_image.jpg')
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

  Widget isButtomTap() {
    if (isButtom) {
      return CircularProgressIndicator(
          backgroundColor: Color.fromRGBO(229, 62, 62, 1),
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    } else {
      return Text('Guardar', style: TextStyle());
    }
  }
}
