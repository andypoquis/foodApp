import 'package:appfood/model/business_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BussinesDetailLogic {
  BussinesDetailLogic(this.business);
  final Business business;

  final TextEditingController textControllerName = TextEditingController();
  final TextEditingController textControllerAddress = TextEditingController();
  late String id;
  late GeoPoint geoPoint;
  void init() {
    if (business != null) {
      textControllerName.text = business.name.toString();
      textControllerAddress.text = business.address.toString();
      id = business.clientId.toString();
      geoPoint = business.geoPoint;
    }
  }

  void save() async {
    final name = textControllerName.text.trim();
    final address = textControllerAddress.text.trim();

    final localBusiness = Business(
        address: address,
        attentionHours: {},
        categories: [],
        clientId: id,
        contactNumber: [],
        geoPoint: geoPoint,
        imageUrl: '',
        menu: [],
        name: name,
        plan: {'id': '63xZJBAvHOMcvCMgxLMz', 'name': 'Gratuito'},
        rubic: 'Restaurante',
        rubicId: 'WaEb51VXnon96ofBcIeX',
        createdAt: DateTime.now(),
        updateAt: DateTime.now());

    final ref = FirebaseFirestore.instance.collection('business');
    if (business != null) {
      final newLocalBusiness = Business(
          address: address,
          attentionHours: {},
          categories: [],
          clientId: id,
          contactNumber: [],
          geoPoint: geoPoint,
          imageUrl: '',
          menu: [],
          name: name,
          plan: {'id': '63xZJBAvHOMcvCMgxLMz', 'name': 'Gratuito'},
          rubic: 'Restaurante',
          rubicId: 'WaEb51VXnon96ofBcIeX',
          createdAt: DateTime.now(),
          updateAt: DateTime.now());
      ref.doc().update(newLocalBusiness.toJson());
    } else {
      ref.add(localBusiness.toJson());
    }
  }
}
