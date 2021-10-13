import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContacNumberPage extends StatefulWidget {
  final String idBusiness;
  final List data;

  ContacNumberPage(this.idBusiness, this.data);

  @override
  _ContacNumberState createState() => _ContacNumberState();
}

class _ContacNumberState extends State<ContacNumberPage> {
  TextEditingController textContrllerPhoneContact = TextEditingController();
  TextEditingController textContrllerDescriptionPhoneContact =
      TextEditingController();

  List dataNumberContact = [];
  @override
  Widget build(BuildContext context) {
    dataNumberContact = widget.data;
    final _sizeScreen = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0))),
      child: Container(
        height: _sizeScreen.height * 0.65,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gestionar números de contacto:',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            //locationContainer(),
            descriptionPhoneTextFiel(_sizeScreen),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                phoneTextFiel(_sizeScreen),
                Expanded(child: Container()),
                addButtonPhone(_sizeScreen, widget.data)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            listContactNumber(),
            // listLocation(_sizeScreen),
          ],
        ),
      ),
    );
  }

  Widget addButtonPhone(sizeScreen, dataContacNumber) {
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
          onPressed: () => addButtonContactPhone(),
          child: Text('Agregar contacto')),
    );
  }

  Widget listContactNumber() {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  color: Colors.grey[300],
                  width: 150,
                  height: 35,
                  child: Center(child: Text('Número')),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey[300],
                    height: 35,
                    child: Center(child: Text('Descripción')),
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
                    itemCount: dataNumberContact.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  //  color: Colors.grey[100],
                                  width: 150,
                                  height: 35,
                                  child: Center(
                                    child: Text(
                                        ' ${dataNumberContact[index]['number']}'),
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
                                          '${dataNumberContact[index]['description']}'),
                                    )),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () => deleteButtonContactPhone(index),
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

  Widget phoneTextFiel(sizeScreen) {
    return Container(
      width: sizeScreen.width * 0.5,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: TextField(
        keyboardType: TextInputType.phone,
        controller: textContrllerPhoneContact,
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Celular',
            icon: Icon(Icons.phone_outlined)),
      ),
    );
  }

  Widget descriptionPhoneTextFiel(sizeScreen) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: textContrllerDescriptionPhoneContact,
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Descripción',
            icon: Icon(Icons.phone_outlined)),
      ),
    );
  }

  void addButtonContactPhone() {
    setState(() {
      dataNumberContact.add({
        'description': textContrllerDescriptionPhoneContact.text,
        'number': textContrllerPhoneContact.text
      });
    });
    CollectionReference business =
        FirebaseFirestore.instance.collection('business');
    List<Map<String, String>> dataConctac = [
      {
        'description': textContrllerDescriptionPhoneContact.text,
        'number': textContrllerPhoneContact.text
      }
    ];
    // print(dataNumberContact.length);
    // for (int i = 0; i < dataNumberContact.length; i++) {
    //   dataConctac.add(dataNumberContact[i]);
    // }

    business
        .doc(widget.idBusiness)
        .update({'contactNumbers': FieldValue.arrayUnion(dataConctac)})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  void deleteButtonContactPhone(int index) {
    CollectionReference business =
        FirebaseFirestore.instance.collection('business');

    business.doc(widget.idBusiness).update({
      'contactNumbers': FieldValue.arrayRemove([dataNumberContact[index]])
    });
    setState(() {
      dataNumberContact.removeAt(index);
    });
  }
}
