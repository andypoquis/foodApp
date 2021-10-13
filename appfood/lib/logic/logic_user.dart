import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appfood/model/user_model.dart';
import 'package:flutter/foundation.dart';

class LogicUser {
  ValueNotifier<List<User>> users = ValueNotifier(null!);
  late StreamSubscription _streamSubscription;

  void getUsers(String id) {
    _streamSubscription = FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .snapshots()
        .listen((onData) {
      users.value = onData.docs.map((item) {
        final id = item.id;
        final data = item.data;
        data()['id'] = id;
        return User.fromMap(data);
      }).toList();
    });
  }

  void cancel() {
    _streamSubscription.cancel();
  }
}
