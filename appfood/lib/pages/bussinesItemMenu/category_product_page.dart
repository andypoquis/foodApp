import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryProductPage extends StatefulWidget {
  String idBusiness;
  final List data;
  CategoryProductPage(this.idBusiness, this.data);
  @override
  _CategoryProductPageState createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  TextEditingController textControllerCategory = TextEditingController();
  List dataCategories = [];
  @override
  Widget build(BuildContext context) {
    final _sizeScreen = MediaQuery.of(context).size;
    dataCategories = widget.data;
    return Container(
      height: _sizeScreen.height * 0.65,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0))),
      child: Column(
        children: [
          Text(
            'Categorias',
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              categoryTextFiel(_sizeScreen),
              Expanded(child: Container()),
              addButtonCategory(_sizeScreen, widget.data)
            ],
          ),
          SizedBox(
            height: 20,
          ),
          listCategories()
        ],
      ),
    );
  }

  Widget categoryTextFiel(sizeScreen) {
    return Container(
      width: sizeScreen.width * 0.45,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: textControllerCategory,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Categoria',
        ),
      ),
    );
  }

  Widget addButtonCategory(sizeScreen, dataContacNumber) {
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
          onPressed: () => addCategory(),
          child: Text('Agregar')),
    );
  }

  Widget listCategories() {
    final sizeScreen = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.grey[300],
                    height: 35,
                    child: Center(child: Text('Categorias')),
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
                    itemCount: dataCategories.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    //  color: Colors.grey[100],
                                    width: 150,
                                    height: 35,
                                    child: Center(
                                      child: Text(' ${dataCategories[index]}'),
                                    )),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () => deleteCategorie(index),
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

  void addCategory() {
    setState(() {
      dataCategories.add(textControllerCategory.text);
    });
    CollectionReference business =
        FirebaseFirestore.instance.collection('business');

    // print(dataNumberContact.length);
    // for (int i = 0; i < dataNumberContact.length; i++) {
    //   dataConctac.add(dataNumberContact[i]);
    // }

    business
        .doc(widget.idBusiness)
        .update({
          'categories': FieldValue.arrayUnion([textControllerCategory.text])
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  deleteCategorie(int index) {
    CollectionReference business =
        FirebaseFirestore.instance.collection('business');
    business
        .doc(widget.idBusiness)
        .update({
          'categories': FieldValue.arrayRemove([dataCategories[index]])
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    setState(() {
      dataCategories.removeAt(index);
    });
  }
}
