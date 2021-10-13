import 'dart:async';

import 'package:appfood/model/business_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class LogicBusinessUser {
  ValueNotifier<List<Business>?> business = ValueNotifier(null);
  StreamSubscription? _streamSubscription;

  void getBusinessUser(String id) {
    _streamSubscription = FirebaseFirestore.instance
        .collection('business')
        .where('clientId', isEqualTo: id)
        .snapshots()
        .listen((onData) {
      business.value = onData.docs.map((item) {
        final id = item.id;
        final data = item.data();
        data['id'] = id;
        return Business.fromMap(data);
      }).toList();
    });
  }

  void cancel() {
    _streamSubscription!.cancel();
  }
}
