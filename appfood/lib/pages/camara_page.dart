import 'dart:io';

import 'package:appfood/pages/business_page/add_button_business_page.dart';
import 'package:appfood/pages/business_page/add_button_produc_page.dart';
import 'package:appfood/pages/business_page/update_business_page.dart';
import 'package:appfood/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class CameraWidget extends StatefulWidget {
  final String nameBusiness, address, idRubrics, nameRubric;
  final String nameProduct, priceProduct, categoryProduct, idBussines;
  final Position? postion;
  final bool isAddProduct;
  final bool? isUpdateBussines;
  const CameraWidget(
    this.isAddProduct,
    this.isUpdateBussines,
    this.nameBusiness,
    this.address,
    this.idRubrics,
    this.idBussines,
    this.nameRubric,
    this.nameProduct,
    this.priceProduct,
    this.categoryProduct, [
    this.postion,
  ]);
  @override
  State createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  TextEditingController textControllerPathUrl = TextEditingController();
  XFile? imageFile = null;
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Opciones",
              style: TextStyle(color: Color(0xff1F2937)),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Color(0xff1F2937),
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Galería"),
                    leading: Icon(
                      Icons.account_box,
                      color: Color(0xff1F2937),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(0xff1F2937),
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camara"),
                    leading: Icon(
                      Icons.camera,
                      color: Color(0xff1F2937),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              child: (imageFile == null)
                  ? Container()
                  : Container(
                      height: 200,
                      width: sizeScreen.width,
                      child: Image.file(
                        File(imageFile!.path),
                        fit: BoxFit.cover,
                      )),
            ),
            MaterialButton(
                textColor: Colors.grey[500],
                onPressed: () {
                  _showChoiceDialog(context);
                },
                child: imageSelectContainer(sizeScreen)),
            SizedBox(
              height: 20,
            ),
            isAddProduct()
          ],
        ),
      ),
    );
  }

  Widget isAddProduct() {
    return (widget.isAddProduct == true)
        ? (widget.isUpdateBussines!)
            ? UpdateButtonBussines(widget.idBussines, widget.nameBusiness,
                widget.nameRubric, textControllerPathUrl.text)
            : AddButtonProduct(
                widget.idBussines,
                widget.nameProduct,
                widget.priceProduct,
                widget.categoryProduct,
                textControllerPathUrl.text,
                widget.nameRubric,
                widget.nameBusiness)
        : AddButtonBusiness(
            widget.nameBusiness,
            widget.address,
            widget.postion!,
            widget.idRubrics,
            widget.nameRubric,
            textControllerPathUrl.text);
  }

  Widget imageSelectContainer(sizeScreen) {
    return (imageFile != null)
        ? Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Palette.kToDark,
                borderRadius: BorderRadius.circular(30)),
            child: Icon(
              Icons.add_photo_alternate,
              color: Color(0xff1F2937),
            ))
        : Container(
            color: Colors.grey[200],
            width: sizeScreen.width,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 65,
                  child: Image.asset(
                    'assets/addImage.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Agregar imagen')
              ],
            ));
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    setState(() {
      imageFile = pickedFile!;
      textControllerPathUrl.text = pickedFile.path;
      print('Url: $imageFile');
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25);
    setState(() {
      imageFile = pickedFile!;
      textControllerPathUrl.text = pickedFile.path;
    });
    Navigator.pop(context);
  }
}
