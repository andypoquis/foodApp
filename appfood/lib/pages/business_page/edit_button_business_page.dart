import 'package:appfood/model/business_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditButtonBusinesPage extends StatefulWidget {
  final String idBusiness, idClient;
  final List dataBusiness;
  EditButtonBusinesPage(this.idBusiness, this.idClient, this.dataBusiness);

  @override
  _EditButtonBusinesPageState createState() => _EditButtonBusinesPageState();
}

class _EditButtonBusinesPageState extends State<EditButtonBusinesPage> {
  bool isButtom = false;
  @override
  Widget build(BuildContext context) {
    final _sizeScreen = MediaQuery.of(context).size;
    CollectionReference bussiness =
        FirebaseFirestore.instance.collection('business');

    Future<void> addBussines() async {
      setState(() {
        isButtom = true;
      });
      final prefs = await SharedPreferences.getInstance();
      bussiness
          .doc(widget.idBusiness)
          .update(Business(
                  address: '',
                  attentionHours: {},
                  categories: [],
                  clientId: prefs.getStringList('data_client')![0],
                  contactNumber: [],
                  createdAt: DateTime.now(),
                  geoPoint: GeoPoint(0, 0),
                  imageUrl: '',
                  menu: [],
                  name: '',
                  plan: {},
                  rubic: '',
                  rubicId: '',
                  updateAt: DateTime.now())
              .toJson())
          .then((value) => print('Negocio agregado'))
          .catchError((error) => print('errorr'));
      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          Navigator.pop(context, true);
        });
      });
    }

    return Container();
  }
}
