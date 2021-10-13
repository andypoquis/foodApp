import 'package:appfood/pages/camara_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ProductMenuPage extends StatefulWidget {
  final String idBusiness;
  final String nameBussiness;
  final List dataMenu;
  final List<String> dataCategory;
  final String nameRubric;

  ProductMenuPage(this.idBusiness, this.nameBussiness, this.dataMenu,
      this.dataCategory, this.nameRubric);
  @override
  _ProductMenuPageState createState() => _ProductMenuPageState();
}

class _ProductMenuPageState extends State<ProductMenuPage> {
  TextEditingController textControllerPrice = TextEditingController();
  TextEditingController textControllerName = TextEditingController();
  TextEditingController textControllerCategory = TextEditingController();
  List dataMenuItem = [];
  Position? uwu;
  String? _chosenValue;
  @override
  Widget build(BuildContext context) {
    dataMenuItem = widget.dataMenu;
    final _sizeScreen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  topLeft: Radius.circular(25.0))),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gestionar menu:',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700]),
                ),
                SizedBox(height: 20),
                //locationContainer(),
                nameTextField(_sizeScreen),

                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    priceTextField(_sizeScreen),
                    Expanded(child: Container()),
                    //categoryProductTextFieldl(_sizeScreen),
                    DropdownButton<String>(
                      value: _chosenValue,
                      style: TextStyle(color: Colors.black),
                      items: widget.dataCategory
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(
                        'Categoria',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _chosenValue = value;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CameraWidget(
                    true,
                    false,
                    widget.nameBussiness,
                    '',
                    '',
                    widget.idBusiness,
                    widget.nameRubric,
                    textControllerName.text,
                    textControllerPrice.text,
                    textControllerCategory.text),
                SizedBox(
                  height: 20,
                ),
                listMenu(),
                // listLocation(_sizeScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget containerButton(sizeScreen, dataContacNumber) {
    return Container(
      width: sizeScreen.width * 0.35,
      height: 55,
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
          onPressed: () => addButtonMenu(),
          child: Text('Agregar producto')),
    );
  }

  Widget listMenu() {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  color: Colors.grey[300],
                  width: 125,
                  height: 35,
                  child: Center(child: Text('Nombre')),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey[300],
                    height: 35,
                    child: Center(child: Text('categoria')),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey[300],
                    height: 35,
                    child: Center(child: Text('Precio')),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  color: Colors.redAccent,
                  width: 30,
                  height: 35,
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.white70,
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: dataMenuItem.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  //  color: Colors.grey[100],
                                  width: 125,
                                  height: 35,
                                  child: Center(
                                    child:
                                        Text(' ${dataMenuItem[index]['name']}'),
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                    //  color: Colors.grey[100],
                                    height: 35,
                                    child: Center(
                                      child: Text(
                                          '${dataMenuItem[index]['category']}'),
                                    )),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                    //  color: Colors.grey[100],
                                    height: 35,
                                    child: Center(
                                      child: Text(
                                          '${dataMenuItem[index]['price']}'),
                                    )),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () => deleteButtonProduct(index),
                                child: Container(
                                  width: 30,
                                  height: 35,
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider()
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget priceTextField(sizeScreen) {
    return Container(
      width: sizeScreen.width * 0.45,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: TextField(
          keyboardType: TextInputType.phone,
          controller: textControllerPrice,
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Precio',
              icon: Icon(Icons.paid_outlined))),
    );
  }

  Widget nameTextField(sizeScreen) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: TextField(
          keyboardType: TextInputType.text,
          controller: textControllerName,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Producto',
          )),
    );
  }

  Widget categoryProductTextFieldl(sizeScreen) {
    return Container(
      width: sizeScreen.width * 0.4,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: textControllerCategory,
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Categoria',
            icon: Icon(Icons.description)),
      ),
    );
  }

  void addButtonMenu() {
    setState(() {
      dataMenuItem.add({
        'category': textControllerCategory.text,
        'image': null,
        'name': textControllerName.text,
        'price': textControllerPrice.text,
      });
    });
    CollectionReference business =
        FirebaseFirestore.instance.collection('business');
    List<Map<String, dynamic>> dataConctac = [
      {
        'category': textControllerCategory.text,
        'image': null,
        'name': textControllerName.text,
        'price': textControllerPrice.text,
      }
    ];
    // print(dataMenuItem.length);
    // for (int i = 0; i < dataMenuItem.length; i++) {
    //   dataConctac.add(dataMenuItem[i]);
    // }

    business
        .doc(widget.idBusiness)
        .update({'menu': FieldValue.arrayUnion(dataConctac)})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  void deleteButtonProduct(int index) {
    CollectionReference business =
        FirebaseFirestore.instance.collection('business');
    business
        .doc(widget.idBusiness)
        .update({
          'menu': FieldValue.arrayRemove([dataMenuItem[index]])
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    setState(() {
      dataMenuItem.removeAt(index);
    });
  }
}
